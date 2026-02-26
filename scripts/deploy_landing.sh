#!/bin/bash
# Configuration
SOURCE_DIR_LANDING="/home/arvind/Desktop/docai/landing"
SOURCE_DIR_NGINX="/home/arvind/Desktop/docai/nginx"
TARGET_DIR="/var/www/geteverythinggpt"
NGINX_CONF_NAME="geteverythinggpt.conf"
NGINX_AVAILABLE="/etc/nginx/sites-available/$NGINX_CONF_NAME"
NGINX_ENABLED="/etc/nginx/sites-enabled/$NGINX_CONF_NAME"

echo "🚀 Starting deployment of GetEverythingGPT landing page..."

# 1. Create target directory
echo "Step 1: Creating target directory $TARGET_DIR..."
sudo mkdir -p $TARGET_DIR

# 2. Copy static files
echo "Step 2: Copying index.html and style.css..."
sudo cp $SOURCE_DIR_LANDING/index.html $TARGET_DIR/
sudo cp $SOURCE_DIR_LANDING/style.css $TARGET_DIR/
sudo chown -R www-data:www-data $TARGET_DIR

# 3. Setup Nginx Configuration
echo "Step 3: Setting up Nginx configuration..."
sudo cp $SOURCE_DIR_NGINX/geteverythinggpt.conf $NGINX_AVAILABLE

# 4. Enable configuration
echo "Step 4: Enabling configuration in sites-enabled..."
if [ -L "$NGINX_ENABLED" ]; then
    sudo rm "$NGINX_ENABLED"
fi
sudo ln -s $NGINX_AVAILABLE $NGINX_ENABLED

# 5. Disable default config if it exists
if [ -L "/etc/nginx/sites-enabled/default" ]; then
    echo "Step 5: Disabling default Nginx config to avoid conflicts..."
    sudo rm /etc/nginx/sites-enabled/default
fi

# 6. Test and Reload
echo "Step 6: Testing Nginx configuration..."
if sudo nginx -t; then
    echo "✅ Nginx config is valid. Reloading..."
    sudo systemctl reload nginx
    echo "🎉 Deployment successful!"
else
    echo "❌ Nginx config test failed. Please check the logs."
    exit 1
fi

