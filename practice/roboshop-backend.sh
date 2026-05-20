#!/bin/bash
# =============================================================================
# Script Name  : roboshop-backend.sh
# Description  : Install and configure backend services for RoboShop
#                Supports Catalogue, User, Cart, Shipping, Payment, Dispatch
#                Component value is injected by Terraform templatefile
# Usage        : Called automatically by Terraform user_data
# =============================================================================

# Color codes
R="\e[31m"   # Red    -> ERROR
G="\e[32m"   # Green  -> SUCCESS
Y="\e[33m"   # Yellow -> INFO
N="\e[0m"    # Reset color

# Terraform injects component value via templatefile
COMPONENT="${component}"

# DNS names - using _DNS suffix to avoid conflict with systemd env variable names
MONGO_DNS="mongodb.awsdevopsjourney.online"
REDIS_DNS="redis.awsdevopsjourney.online"
CATALOGUE_DNS="catalogue.awsdevopsjourney.online"
# RABBITMQ_DNS="rabbitmq.awsdevopsjourney.online"  # uncomment when payment/dispatch added
MYSQL_DNS="mysql.awsdevopsjourney.online"         # uncomment when shipping added

# Log file setup
LOGS_FOLDER="/var/log/shell-script"
mkdir -p "$LOGS_FOLDER"
SCRIPT_NAME="roboshop-backend"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$COMPONENT-$TIMESTAMP.log"

# Current user ID - root=0, normal user=1000+
USER_ID=$(id -u)

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

LOG(){
    echo -e "$TIMESTAMP $1" | tee -a "$LOG_FILE"
}

check_root(){
    if [ "$USER_ID" -ne 0 ]; then
        LOG "$${R}ERROR: Please run the script with root privileges$${N}"
        exit 1
    else
        LOG "$${G}SUCCESS: Running as root user$${N}"
    fi
}

# $? = exit code of last command (0=success, non-zero=failure)
check_status(){
    if [ $? -eq 0 ]; then
        LOG "$${G}SUCCESS: $1$${N}"
    else
        LOG "$${R}ERROR: $1 failed. Check log: $LOG_FILE$${N}"
        exit 1
    fi
}

# $1 = exit code from dnf list installed
# $2 = package name
validate_installation(){
    if [ $1 -ne 0 ]; then
        LOG "$${Y}INFO: $2 is not installed. Going to install it...$${N}"
        dnf install "$2" -y &>> "$LOG_FILE"
        check_status "Installing $2"
    else
        LOG "$${G}SUCCESS: $2 is already installed. Nothing to do...$${N}"
    fi
}

# =============================================================================
# application language used by services
# =============================================================================

# Disable NodeJS 10 (default) and enable NodeJS 20
install_nodejs(){
    LOG "$${Y}INFO: Starting NodeJS Installation...$${N}"
    for module in "disable nodejs" "enable nodejs:20"; do
        dnf module $module -y &>> "$LOG_FILE"
        check_status "dnf module $module"
    done
    dnf list installed nodejs &>> "$LOG_FILE"
    validate_installation $? "nodejs"
    node -v &>> "$LOG_FILE"
    check_status "NodeJS version verification"
    LOG "$${G}NodeJS Installation Completed Successfully!$${N}"
}

# =============================================================================
# COMMON FUNCTIONS
# =============================================================================

# Create roboshop daemon user if not exists
# roboshop user runs the application - not for login
add_app_user(){
    if id roboshop &>> "$LOG_FILE"; then
        LOG "$${G}SUCCESS: roboshop user already exists. Skipping...$${N}"
    else
        useradd roboshop &>> "$LOG_FILE"
        check_status "roboshop user creation"
    fi
}

# Clean /app for fresh deployment
# exists   → remove old code
# missing  → create fresh directory
setup_app_directory(){
    if [ -d /app ]; then
        LOG "$${Y}INFO: /app exists. Removing old code for fresh deployment...$${N}"
        rm -rf /app/* &>> "$LOG_FILE"
        check_status "Removing old application files"
    else
        LOG "$${Y}INFO: Creating fresh /app directory...$${N}"
        mkdir -p /app &>> "$LOG_FILE"
        check_status "Creating /app directory"
    fi
}

# Download and extract app code from S3
# $1 = component name (catalogue/user/cart)
# downloads /tmp/<component>.zip and extracts to /app
download_app(){
    local app=$1
    LOG "$${Y}INFO: Downloading $app code from S3...$${N}"
    curl -L -o /tmp/$app.zip \
        https://roboshop-builds.s3.amazonaws.com/$app.zip &>> "$LOG_FILE"
    check_status "Downloading $app zip"
    LOG "$${Y}INFO: Extracting $app code to /app...$${N}"
    cd /app
    unzip /tmp/$app.zip &>> "$LOG_FILE"
    check_status "Extracting $app zip"
}

# Common NodeJS app setup steps
# nodejs + user + /app + unzip + download + npm install
# $1 = component name
install_nodejs_app(){
    local app=$1
    install_nodejs
    add_app_user
    setup_app_directory
    dnf list installed unzip &>> "$LOG_FILE"
    validate_installation $? "unzip"
    download_app "$app"
    LOG "$${Y}INFO: Installing NodeJS dependencies for $app...$${N}"
    cd /app
    npm install &>> "$LOG_FILE"
    check_status "NPM install for $app"
}

# daemon-reload + enable + start + verify
# $1 = service name
setup_systemd_service(){
    local service=$1
    LOG "$${Y}INFO: Setting up systemd service for $service...$${N}"
    systemctl daemon-reload &>> "$LOG_FILE"
    check_status "Daemon reload"
    for action in enable start; do
        systemctl $action $service &>> "$LOG_FILE"
        check_status "$service service $action"
    done
    systemctl is-active $service &>> "$LOG_FILE"
    check_status "$service service verification"
}

# Setup MongoDB repo and install mongosh client
# mongosh needed to load schemas into MongoDB
# called only by catalogue and user
setup_mongo_repo(){
    LOG "$${Y}INFO: Setting up MongoDB repository...$${N}"
    cat <<EOF > /etc/yum.repos.d/mongo.repo
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-7.0.asc
EOF
    check_status "MongoDB repository setup"
    dnf list installed mongodb-mongosh &>> "$LOG_FILE"
    validate_installation $? "mongodb-mongosh"
}

# Load MongoDB schema from /app/schema/<service>.js
# $1 = service name (catalogue/user)
load_mongo_schema(){
    local service=$1
    LOG "$${Y}INFO: Loading MongoDB schema for $service...$${N}"
    mongosh --host $MONGO_DNS \
        < /app/schema/$service.js &>> "$LOG_FILE"
    check_status "Loading $service schema"
}

# =============================================================================
# SERVICE INSTALLATION FUNCTIONS
# =============================================================================

# Catalogue - NodeJS service for product listings
# Depends on MongoDB for product data
install_catalogue(){
    LOG "$${Y}INFO: Starting Catalogue Service Installation...$${N}"
    install_nodejs_app "catalogue"
    LOG "$${Y}INFO: Creating catalogue systemd service file...$${N}"
    cat <<EOF > /etc/systemd/system/catalogue.service
[Unit]
Description=Catalogue Service

[Service]
User=roboshop
Environment=MONGO=true
Environment=MONGO_URL="mongodb://$MONGO_DNS:27017/catalogue"
ExecStart=/bin/node /app/server.js
SyslogIdentifier=catalogue

[Install]
WantedBy=multi-user.target
EOF
    check_status "Catalogue service file creation"
    setup_systemd_service "catalogue"
    setup_mongo_repo
    load_mongo_schema "catalogue"
    LOG "$${G}Catalogue Service Installation Completed Successfully!$${N}"
}

# User - NodeJS service for login and registration
# Depends on MongoDB for user data
# Depends on Redis for session caching
install_user(){
    LOG "$${Y}INFO: Starting User Service Installation...$${N}"
    install_nodejs_app "user"
    LOG "$${Y}INFO: Creating user systemd service file...$${N}"
    cat <<EOF > /etc/systemd/system/user.service
[Unit]
Description=User Service

[Service]
User=roboshop
Environment=MONGO=true
Environment=REDIS_HOST=$REDIS_DNS
Environment=MONGO_URL="mongodb://$MONGO_DNS:27017/users"
ExecStart=/bin/node /app/server.js
SyslogIdentifier=user

[Install]
WantedBy=multi-user.target
EOF
    check_status "User service file creation"
    setup_systemd_service "user"
    setup_mongo_repo
    load_mongo_schema "user"
    LOG "$${G}User Service Installation Completed Successfully!$${N}"
}

# Cart - NodeJS service for shopping cart
# Depends on Redis for cart data
# Depends on Catalogue for product details
# Does NOT need MongoDB schema
install_cart(){
    LOG "$${Y}INFO: Starting Cart Service Installation...$${N}"
    install_nodejs_app "cart"
    LOG "$${Y}INFO: Creating cart systemd service file...$${N}"
    cat <<EOF > /etc/systemd/system/cart.service
[Unit]
Description=Cart Service

[Service]
User=roboshop
Environment=REDIS_HOST=$REDIS_DNS
Environment=CATALOGUE_HOST=$CATALOGUE_DNS
Environment=CATALOGUE_PORT=8080
ExecStart=/bin/node /app/server.js
SyslogIdentifier=cart

[Install]
WantedBy=multi-user.target
EOF
    check_status "Cart service file creation"
    setup_systemd_service "cart"
    LOG "$${G}Cart Service Installation Completed Successfully!$${N}"
}


# =============================================================================
# MAIN SCRIPT STARTS HERE
# =============================================================================

LOG "$${Y}========================================$${N}"
LOG "$${Y}   RoboShop - $COMPONENT Installation   $${N}"
LOG "$${Y}========================================$${N}"

LOG "$${Y}INFO: Checking root user...$${N}"
check_root

LOG "$${Y}INFO: Starting installation for: $COMPONENT...$${N}"
case $COMPONENT in
    catalogue)
        install_catalogue
        ;;
    user)
        install_user
        ;;
    cart)
        install_cart
        ;;
    # shipping)  install_shipping  ;;  # uncomment when shipping doc added
    # payment)   install_payment   ;;  # uncomment when payment doc added
    # dispatch)  install_dispatch  ;;  # uncomment when dispatch doc added
    *)
        LOG "$${R}ERROR: Invalid component: $COMPONENT$${N}"
        LOG "$${R}ERROR: Valid: catalogue, user, cart$${N}"
        exit 1
        ;;
esac

# =============================================================================
# SCRIPT COMPLETED
# =============================================================================
LOG "$${G}========================================$${N}"
LOG "$${G}   $COMPONENT Installation Completed!   $${N}"
LOG "$${G}========================================$${N}"
LOG "$${Y}INFO: Full log available at: $LOG_FILE$${N}"