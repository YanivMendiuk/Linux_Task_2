#!/usr/bin/env bash
# -----------------------------------------------------
# Script Name:    install_non_apt_packages.sh
# Version:        1.1.0
# Author:         Yaniv Mendiuk
# Date:           2025-03-08
# Description:
# This script automates the installation of Nginx and the setup of a new virtual host on both
# Debian-based and RHEL-based systems. It performs the following tasks:
# 1. Checks for root or sudo privileges.
# 2. Detects the operating system type.
# 3. Installs Nginx if not already installed.
# 4. Prompts for a domain name and checks if a virtual host is configured.
# 5. Creates a configuration file from a template for the new virtual host.
# 6. Sets up the document root and updates the `/etc/hosts` file.
# 7. Tests the Nginx configuration and restarts the service.

set -o errexit
set -o pipefail
# -----------------------------------------------------
if [[ $EUID -eq 0 ]];
then
echo "Running as root"
elif sudo -l &>/dev/null;
then
echo "User has sudo privilges"
else
echo "This script must run with sudo privilges or root user"
exit 1
fi

# Checking which OS
whichOS=$(cat /etc/os-release | grep "ID_LIKE=" | sed 's/ID_LIKE=//')
echo "Detected OS: $whichOS"

install_debian() {

echo "Setting up for Debian based OS..."

if dpkg-query -s nginx | grep "Status: install ok installed";
then
echo "Nginx is already installed"
else
echo "Installing Nginx..."
sudo apt-get install nginx -y;
fi

if dpkg-query -s nginx-extras | grep "Status: install ok installed";
then
echo "nginx-extras is already installed"
else
echo "Installing Nginx..."
sudo apt-get install nginx-extras -y;
fi

}

install_rhel() {

echo "Setting up for RHEL based OS..."

if ! rpm -q nginx;
then
echo "Installing Nginx..."
sudo dnf install nginx -y;
else
echo "Nginx is already installed"
fi

}


case $whichOS in
    *debian*) install_debian ;;
    *fedora*) install_rhel ;;
    *) echo "$whichOS is not supported" && exit 1 ;;
esac

# Verifying if domain name exists

read -p "This is a check if virtual host is configured.
Please inert your domain name:
" domain_name
if [[ -e "/etc/nginx/sites-available/$domain_name" ]];
then
echo "Your domain name is already configured as a virtual host"
else
echo "Adding your virtual host, $domain_name, to the sites available. Please assist with providing the relevant information."
fi

# Ask for domain name
read -p "Please type once again your domain name:
" domain_name

# Ensure the sites-available directory exists
sudo mkdir -p /etc/nginx/sites-available/
sudo mkdir -p /etc/nginx/sites-enabled/

# Creating a configuration file from templates/nginx_site.tmpl and configuring it with new $domain_name

sudo sed "s/{{DOMAIN_NAME}}/$domain_name/g" templates/nginx_site.tmpl | sudo tee /etc/nginx/sites-available/$domain_name

# Create a symbolic link in sites-enabled

sudo ln -s /etc/nginx/sites-available/$domain_name /etc/nginx/sites-enabled/$domain_name

echo "Configuring /var/www/ for $domain_name."
sudo mkdir -p /var/www/$domain_name
sudo touch /var/www/$domain_name/index.html
echo "<h1> Welcome to $domain_name</h1>" | sudo tee /var/www/$domain_name/index.html

# Adding new domain to /etc/hosts
echo "127.0.0.1       $domain_name                    $domain_name" | sudo tee -a /etc/hosts

# Checking if new configuration is OK.
sudo nginx -t

# Restatring nginx service to load the latest configuration.
sudo systemctl restart nginx

# Checking if the new virtual host is accsiable:
sleep 2
curl -v $domain_name
