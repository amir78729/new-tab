#!/bin/bash

# Variables
SCRIPT_NAME="server.js"
PROCESS_NAME="new-tab"

echo "Starting setup to make $SCRIPT_NAME a daemon..."

# Check if PM2 is installed
if ! command -v pm2 &> /dev/null; then
  echo "PM2 is not installed. Installing PM2..."
  npm install -g pm2
else
  echo "PM2 is already installed."
fi

# Start the server.js process with PM2
echo "Starting $SCRIPT_NAME with PM2..."
pm2 start $SCRIPT_NAME --name $PROCESS_NAME

# Save PM2 process list
echo "Saving PM2 process list..."
pm2 save

# Set up PM2 to start on system reboot
echo "Configuring PM2 startup script..."
STARTUP_COMMAND=$(pm2 startup | tail -n 1) # Gets the last command from the pm2 startup output
eval $STARTUP_COMMAND

echo "$PROCESS_NAME is now set up as a daemon and will start on boot!"
