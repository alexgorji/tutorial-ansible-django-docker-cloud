### Step-3: SSL Let's Encrypt Setup

1. **Add Certbot Certificates to Projects (Staging or Production)**:
   - Added certificate options to `nginx-sites-enabled` and created a new `create-certificate` tasks file.
   - Add an email address to `env_vars/base.yml` for Certbot to send warning messages if a certificate is expiring.
   - Add a certbot path on server in `env_vars/base.yml` 
   - Set `ssl` and `staging` variables in `env_vars/projects.yml`:
     - If `ssl` is false or not set, no certificate check takes place.
     - If `ssl` is true:
       - If `staging` is false or not set:
         - If no certificate exists or the certificate was a staging certificate, a new production certificate will be created.
       - If `staging` is true:
         - If no certificate exists or the certificate was a production certificate, a new staging certificate will be created.
   - An extra `sites-enabled` file will be used temporarily to create the certificate. (see `roles\deploy-projects\templates\nginx\create-certificate.j2`)

2. **Set Up Nginx for Port 443**:
   - The `roles\deploy-projects\templates\nginx\nginx-html-443.js` handles HTTPS configuration in Nginx.
   - Currently, there is no default Nginx configuration. For example, if you have domains A, B, and C pointing to your server's IP address and A listens to port 80, B listens to port 443, and C is not configured:
     - Visiting http://C will display the Nginx successful installation message.
     - Visiting https://A and https://C will be redirected to https://B. In this scenario, B is the first domain listening on port 443 and is treated as the default domain.
     - TODO: Set up a default `sites-enabled` file to return 404 errors in both cases mentioned above. To achieve this behavior on port 443, you will need to create an invalid self-signed SSL certificate.

3. **Manage Certificate Renewals**:
   - Review `roles\deploy-projects\templates\docker\certbot.j2`.
   - A `certbot-renewal` container will run for each domain with `ssl` set to true.

### Setting up Your Machine:
1. Follow the setup steps described in Step-1 and Step-2.
2. Add your email address to `env_vars/base.yml` as `certbot_email`.
3. Update `certbot_path` in `env_vars/base.yml` if needed.
3. Use variables `ssl` and `staging` for your projects in `env_vars/projects.yml`.
