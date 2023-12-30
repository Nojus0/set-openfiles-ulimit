#!/bin/bash

# Set the desired limit
LIMIT=$1

if [ -z "$LIMIT" ] ; then
    echo "Please provide the new open files ulimit. 'sudo ./set_ulimit.sh 100000'"
    exit 1
fi

# Remove existing lines related to nofile in /etc/security/limits.conf
sudo sed -i '/^\s*\*\s*soft\s*nofile/d' /etc/security/limits.conf
sudo sed -i '/^\s*\*\s*hard\s*nofile/d' /etc/security/limits.conf

# Add new limit to /etc/security/limits.conf
echo "* soft nofile $LIMIT" | sudo tee -a /etc/security/limits.conf > /dev/null
echo "* hard nofile $LIMIT" | sudo tee -a /etc/security/limits.conf > /dev/null

# Remove existing line related to pam_limits.so in /etc/pam.d/common-session
sudo sed -i '/^\s*session\s*required\s*pam_limits.so/d' /etc/pam.d/common-session

# Add new line to /etc/pam.d/common-session
echo "session required pam_limits.so" | sudo tee -a /etc/pam.d/common-session > /dev/null

echo "The ulimit is now $LIMIT"
