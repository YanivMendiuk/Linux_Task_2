#!/usr/bin/env bash
# -----------------------------------------------------
# Script Name:    install_non_apt_packages.sh
# Version:        1.1.0
# Author:         Yaniv Mendiuk
# Date:           2025-03-08
# Description:    This script installs kubectl and AWS CLI by:
#                 1. Adding the Kubernetes package repository and installing kubectl.
#                 2. Downloading, extracting, and installing AWS CLI.
#                 3. Ensuring proper configuration and verification of installations.
set -o errexit
set -o pipefail
set -x
# -----------------------------------------------------

read -p "This is a check if virtual host is configured. 
Please inert your domain name:
" domain_name
if [ -e "/etc/nginx/sites-available/$domain_name" ]; 
then
echo "Your domain name is already configured as a virtual host"
else
echo "Adding your virtual host, $domain_name, to the sites available. Please assist with providing the relevant information."
./configuring_new_virtual_host.sh
fi
