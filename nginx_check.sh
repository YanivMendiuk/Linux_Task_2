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

# Checking if Nginx is installed and if not installing

if dpkg-query -s nginx | awk '/^Status:/' | grep "install ok installed"; 
then 
echo "Nginx is already installed"
else
echo "Installing Nginx"
sudo apt-get install nginx;
fi


