# Linux_Task_2 -  Nginx and Virtual Host Set Up Script

## Overview

This project automates the setup of Nginx and the verification/installation of your virtual host. If Nginx is not installed or your virtual host is not configured, this script will help with the installation and configuration of your virtual host.  

## Files Included

### 1. `setup_nginx_and_virtual_host.sh`

This script automates the installation of Nginx and the setup of a new virtual host on both
Debian-based and RHEL-based systems. It performs the following tasks:

1. Checks for root or sudo privileges.
2. Detects the operating system type.
3. Installs Nginx if not already installed.
4. Prompts for a domain name and checks if a virtual host is configured.
5. Creates a configuration file from a template for the new virtual host.
6. Sets up the document root and updates the `/etc/hosts` file.
7. Tests the Nginx configuration and restarts the service.

### 2. `templates/nginx_site.tmpl`

This directory will include the nginx site template file configuration. This will be used in the `setup_nginx_and_virtual_host.sh` in section 5 in the tasks above.

## Installation & Usage

### Clone the Repository

```bash
git clone https://github.com/YanivMendiuk/Linux_Task_2.git
```

### Run the Setup script

```bash
./setup_nginx_and_virtual_host.sh
```

### Requiremnets

- Root user / `sudo` privileges.
- A Debian-based / RHEL Linux distribution.
- For RHEL OS users, ensure that you running on RHEL8 or above or install dnf prior for running this script.
