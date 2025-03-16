# Nginx Task  

This script automates the setup of `user_dir`, authentication, authentication with PAM, and CGI scripting for Nginx.  

## **Tasks**  

1. **Check if Nginx is installed**  
   - If not, prompt the user to install it.  

2. **Check if a virtual host is configured**  
   - If missing, ask for a virtual host name and configure it.  

3. **Ensure required dependencies are installed**  
   - Dependencies for `user_dir`, authentication, and CGI scripting will be checked and installed if missing.  

4. **Support argument-based installation**  
   - The script should allow users to specify which features to install/configure through arguments.  

## **Reference**  
For more details, refer to this [Nginx Shallow Dive](https://gitlab.com/vaiolabs-io/nginx-shallow-dive).  

