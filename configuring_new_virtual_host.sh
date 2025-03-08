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

read -p "Please type once again your domain name:
" domain_name
echo "configuring the sites-available"
sudo touch /etc/nginx/sites-available/$domain_name

server {
    listen 80;
    server_name $domain_name;

    root /var/www/$domain_name;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }
}

echo "configuring the /var/www/"
sudo mkdir /var/www/$domain_name
sudo touch /var/www/$domain_name/index.html
echo "<h1> Welcome to $domain_name</h1>" | sudo tee /var/www/$domain_name/index.html
