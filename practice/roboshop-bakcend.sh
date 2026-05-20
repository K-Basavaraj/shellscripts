#!/bin/bash
# =============================================================================
# Script Name  : roboshop-backend.sh
# Description  : Install and configure backend services for RoboShop
#                Supports Catalogue, User, Cart, Shipping, Payment, Dispatch
#                Component value is injected by Terraform templatefile
# Usage        : Called automatically by Terraform user_data
# =============================================================================

# -----------------------------------------------------------------------------
# Color codes for logging output
# -----------------------------------------------------------------------------
R="\e[31m"   # Red    -> ERROR
G="\e[32m"   # Green  -> SUCCESS
Y="\e[33m"   # Yellow -> INFO
N="\e[0m"    # Reset color

# -----------------------------------------------------------------------------
# Terraform injects component value via templatefile
# Possible values: catalogue / user / cart / shipping / payment / dispatch
# -----------------------------------------------------------------------------
COMPONENT="${component}"

# -----------------------------------------------------------------------------
# DNS names for all services
# Using _DNS suffix to avoid conflict with
# environment variable names in systemd service files
# → IPs can change if server restarts
# → DNS names always point to correct server
# → Route53 handles IP resolution automatically
# -----------------------------------------------------------------------------
MONGO_DNS="mongodb.awsdevopsjourney.online"
REDIS_DNS="redis.awsdevopsjourney.online"
CATALOGUE_DNS="catalogue.awsdevopsjourney.online"
# RABBITMQ_DNS="rabbitmq.awsdevopsjourney.online"
# MYSQL_DNS="mysql.awsdevopsjourney.online"

# -----------------------------------------------------------------------------
# Log file setup
# -----------------------------------------------------------------------------
LOGS_FOLDER="/var/log/shell-script"
mkdir -p "$LOGS_FOLDER"
SCRIPT_NAME="roboshop-backend"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$COMPONENT-$TIMESTAMP.log"

# -----------------------------------------------------------------------------
# USER_ID : stores current user ID
# root = 0, normal user = 1000+
# -----------------------------------------------------------------------------
USER_ID=$(id -u)

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# -----------------------------------------------------------------------------
# FUNCTION : LOG
# Purpose  : Print timestamped message to console and log file
# -----------------------------------------------------------------------------
LOG(){
    echo -e "$TIMESTAMP $1" | tee -a "$LOG_FILE"
}

# -----------------------------------------------------------------------------
# FUNCTION : check_root
# Purpose  : Ensure script runs as root user
# -----------------------------------------------------------------------------
check_root(){
    if [ "$USER_ID" -ne 0 ]; then
        LOG "$${R}ERROR: Please run the script with root privileges$${N}"
        exit 1
    else
        LOG "$${G}SUCCESS: Running as root user$${N}"
    fi
}

# -----------------------------------------------------------------------------
# FUNCTION : check_status
# Purpose  : Verify last command succeeded or failed
# $?       : exit code of last command (0=success, non-zero=failure)
# -----------------------------------------------------------------------------
check_status(){
    if [ $? -eq 0 ]; then
        LOG "$${G}SUCCESS: $1$${N}"
    else
        LOG "$${R}ERROR: $1 failed. Check log: $LOG_FILE$${N}"
        exit 1
    fi
}

# -----------------------------------------------------------------------------
# FUNCTION : validate_installation
# Purpose  : Check if package is already installed
#            If not installed → install it
#            If already installed → skip
# Usage    : validate_installation $? "package-name"
# -----------------------------------------------------------------------------
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
# COMMON FUNCTIONS
# =============================================================================

# -----------------------------------------------------------------------------
# FUNCTION : install_nodejs
# Purpose  : Install and configure NodeJS 20
#            Required for catalogue, user and cart services
#            By default RHEL has NodeJS 10
#            We disable 10 and enable 20
# -----------------------------------------------------------------------------
install_nodejs(){
    LOG "$${Y}INFO: Starting NodeJS Installation...$${N}"

    # Disable default NodeJS 10 and enable NodeJS 20
    for module in "disable nodejs" "enable nodejs:20"; do
        LOG "$${Y}INFO: Running dnf module $module...$${N}"
        dnf module $module -y &>> "$LOG_FILE"
        check_status "dnf module $module"
    done

    # Install NodeJS if not already installed
    dnf list installed nodejs &>> "$LOG_FILE"
    validate_installation $? "nodejs"

    # Verify NodeJS version
    LOG "$${Y}INFO: Verifying NodeJS installation...$${N}"
    node -v &>> "$LOG_FILE"
    check_status "NodeJS version verification"

    LOG "$${G}NodeJS Installation Completed Successfully!$${N}"
}

# -----------------------------------------------------------------------------
# FUNCTION : add_app_user
# Purpose  : Create roboshop daemon user if not exists
#            roboshop user runs the application process
#            not used for login purposes
# -----------------------------------------------------------------------------
add_app_user(){
    LOG "$${Y}INFO: Checking roboshop user existence...$${N}"
    if id roboshop &>> "$LOG_FILE"; then
        LOG "$${G}SUCCESS: roboshop user already exists. Skipping...$${N}"
    else
        LOG "$${Y}INFO: Creating roboshop user...$${N}"
        useradd roboshop &>> "$LOG_FILE"
        check_status "roboshop user creation"
    fi
}

# -----------------------------------------------------------------------------
# FUNCTION : setup_app_directory
# Purpose  : Prepare /app directory for fresh deployment
#            If exists → removes old code (clean deployment)
#            If not exists → creates fresh directory
# -----------------------------------------------------------------------------
setup_app_directory(){
    LOG "$${Y}INFO: Setting up /app directory...$${N}"
    if [ -d /app ]; then
        LOG "$${Y}INFO: /app exists. Removing old code for fresh deployment...$${N}"
        rm -rf /app/* &>> "$LOG_FILE"
        check_status "Removing old application files"
    else
        LOG "$${Y}INFO: /app does not exist. Creating fresh directory...$${N}"
        mkdir -p /app &>> "$LOG_FILE"
        check_status "Creating /app directory"
    fi
    LOG "$${G}SUCCESS: /app directory setup completed!$${N}"
}

# -----------------------------------------------------------------------------
# FUNCTION : download_app
# Purpose  : Download and extract application code from S3
# $1       : component name
#            example: download_app "catalogue"
#            $1        = "catalogue"
#            downloads = catalogue.zip from S3
#            extracts  = to /app directory
# -----------------------------------------------------------------------------
download_app(){
    # local = variable only lives inside this function
    # app   = component name passed as argument
    # $1    = first argument when calling function
    #         example: download_app "catalogue"
    #                  $1 = "catalogue"
    local app=$1

    # Download zip from S3
    # -L = follow redirects
    # -o = save to specific path /tmp/<component>.zip
    LOG "$${Y}INFO: Downloading $app code from S3...$${N}"
    curl -L -o /tmp/$app.zip \
        https://roboshop-builds.s3.amazonaws.com/$app.zip &>> "$LOG_FILE"
    check_status "Downloading $app zip"

    # Extract zip to /app directory
    # cd /app first so content extracts correctly
    LOG "$${Y}INFO: Extracting $app code to /app...$${N}"
    cd /app
    unzip /tmp/$app.zip &>> "$LOG_FILE"
    check_status "Extracting $app zip"
}

# -----------------------------------------------------------------------------
# FUNCTION : install_nodejs_app
# Purpose  : Common setup steps for all NodeJS services
#            Handles nodejs, user, directory, unzip,
#            download and npm install in one function
#            Reduces repetition across catalogue, user, cart
# Usage    : install_nodejs_app "catalogue"
# $1       : component name
# -----------------------------------------------------------------------------
install_nodejs_app(){
    local app=$1

    # Install NodeJS 20
    install_nodejs

    # Create roboshop daemon user
    add_app_user

    # Setup /app directory (clean old code)
    setup_app_directory

    # Install unzip if not already installed
    # unzip is needed to extract application zip
    # installed here once instead of every download_app call
    dnf list installed unzip &>> "$LOG_FILE"
    validate_installation $? "unzip"

    # Download and extract application code
    download_app "$app"

    # Install NodeJS dependencies
    # package.json contains all required dependencies
    # npm install reads package.json and installs them
    LOG "$${Y}INFO: Installing NodeJS dependencies for $app...$${N}"
    cd /app
    npm install &>> "$LOG_FILE"
    check_status "NPM install for $app"
}

# -----------------------------------------------------------------------------
# FUNCTION : setup_systemd_service
# Purpose  : Load and start systemd service
#            Common for all backend services
# Usage    : setup_systemd_service "catalogue"
# $1       : service name
# -----------------------------------------------------------------------------
setup_systemd_service(){
    local service=$1
    LOG "$${Y}INFO: Setting up systemd service for $service...$${N}"

    # Reload systemd to pick up new service file
    systemctl daemon-reload &>> "$LOG_FILE"
    check_status "Daemon reload"

    # Enable and start service
    # enable → auto starts on reboot
    # start  → starts service now
    for action in enable start; do
        LOG "$${Y}INFO: Running systemctl $action $service...$${N}"
        systemctl $action $service &>> "$LOG_FILE"
        check_status "$service service $action"
    done

    # Verify service is running
    LOG "$${Y}INFO: Verifying $service service status...$${N}"
    systemctl is-active $service &>> "$LOG_FILE"
    check_status "$service service verification"
}

# -----------------------------------------------------------------------------
# FUNCTION : setup_mongo_repo
# Purpose  : Setup MongoDB repository and install mongosh client
#            mongosh client needed to load schemas into MongoDB
#            Called only by catalogue and user services
# -----------------------------------------------------------------------------
setup_mongo_repo(){
    LOG "$${Y}INFO: Setting up MongoDB repository...$${N}"

    # Create MongoDB repo file
    # allows dnf to find and install mongodb packages
    cat <<EOF > /etc/yum.repos.d/mongo.repo
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-7.0.asc
EOF
    check_status "MongoDB repository setup"

    # Install mongosh client if not already installed
    dnf list installed mongodb-mongosh &>> "$LOG_FILE"
    validate_installation $? "mongodb-mongosh"
}

# -----------------------------------------------------------------------------
# FUNCTION : load_mongo_schema
# Purpose  : Load MongoDB schema for the service
#            Schema files are part of application code
#            Located at /app/schema/<service>.js
# Usage    : load_mongo_schema "catalogue"
# $1       : service name
# -----------------------------------------------------------------------------
load_mongo_schema(){
    local service=$1
    LOG "$${Y}INFO: Loading MongoDB schema for $service...$${N}"

    # Connect to MongoDB using DNS name
    # Load schema from /app/schema/<service>.js
    mongosh --host $MONGO_DNS \
        < /app/schema/$service.js &>> "$LOG_FILE"
    check_status "Loading $service schema"
}

# =============================================================================
# SERVICE INSTALLATION FUNCTIONS
# =============================================================================

# -----------------------------------------------------------------------------
# FUNCTION : install_catalogue
# Purpose  : Install and configure Catalogue service
#            NodeJS service that serves product listings
#            Depends on MongoDB for product data
# -----------------------------------------------------------------------------
install_catalogue(){
    LOG "$${Y}INFO: Starting Catalogue Service Installation...$${N}"

    # Common NodeJS steps
    # nodejs + user + /app + unzip + download + npm install
    install_nodejs_app "catalogue"

    # Create catalogue systemd service file
    # MONGO_URL → MongoDB connection for product data
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

    # Enable and start catalogue service
    setup_systemd_service "catalogue"

    # Setup mongosh and load catalogue schema into MongoDB
    setup_mongo_repo
    load_mongo_schema "catalogue"

    LOG "$${G}Catalogue Service Installation Completed Successfully!$${N}"
}

# -----------------------------------------------------------------------------
# FUNCTION : install_user
# Purpose  : Install and configure User service
#            NodeJS service for user login and registration
#            Depends on MongoDB for user data
#            Depends on Redis for session caching
# -----------------------------------------------------------------------------
install_user(){
    LOG "$${Y}INFO: Starting User Service Installation...$${N}"

    # Common NodeJS steps
    install_nodejs_app "user"

    # Create user systemd service file
    # MONGO_URL  → MongoDB for user data storage
    # REDIS_HOST → Redis for session caching
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

    # Enable and start user service
    setup_systemd_service "user"

    # Setup mongosh and load user schema into MongoDB
    setup_mongo_repo
    load_mongo_schema "user"

    LOG "$${G}User Service Installation Completed Successfully!$${N}"
}

# -----------------------------------------------------------------------------
# FUNCTION : install_cart
# Purpose  : Install and configure Cart service
#            NodeJS service for shopping cart management
#            Depends on Redis for cart data caching
#            Depends on Catalogue for product details
#            Does NOT need MongoDB schema
# -----------------------------------------------------------------------------
install_cart(){
    LOG "$${Y}INFO: Starting Cart Service Installation...$${N}"

    # Common NodeJS steps
    install_nodejs_app "cart"

    # Create cart systemd service file
    # REDIS_HOST     → Redis for cart data caching
    # CATALOGUE_HOST → Catalogue for product details
    # CATALOGUE_PORT → Catalogue listens on port 8080
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

    # Enable and start cart service
    setup_systemd_service "cart"

    # NOTE: Cart does NOT need MongoDB schema
    # Cart uses Redis for storage not MongoDB

    LOG "$${G}Cart Service Installation Completed Successfully!$${N}"
}

# =============================================================================
# MAIN SCRIPT STARTS HERE
# =============================================================================

LOG "$${Y}========================================$${N}"
LOG "$${Y}   RoboShop - $COMPONENT Installation   $${N}"
LOG "$${Y}========================================$${N}"

# Check root user before doing anything
LOG "$${Y}INFO: Checking root user...$${N}"
check_root

# Identify component and call relevant install function
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
    # shipping)
    #     install_shipping
    #     ;;
    # payment)
    #     install_payment
    #     ;;
    # dispatch)
    #     install_dispatch
    #     ;;
    *)
        LOG "$${R}ERROR: Invalid component: $COMPONENT$${N}"
        LOG "$${R}ERROR: Valid: catalogue, user, cart, shipping, payment, dispatch$${N}"
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