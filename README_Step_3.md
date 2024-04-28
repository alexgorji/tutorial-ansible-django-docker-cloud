### Step-3: SSL Let's Encrypt Setup

1. **Add Certbot certificates to projects (staging or production)**:
  - Added certificate options to `nginx-sites-enabled` and created a new  `cerate-certificate` tasks file.
    - You need to add an email address to `env_vars/base.yml` for certbot to get warning messages if a certificate is getting expired.
    - Set `ssl` and `staging` variables in `env_vars/projects.yml`:
      - `ssl` is false or not set: No certificate check takes place.
      - `ssl` is true:
        - `staging` is false or not set: If no certificate exists or the certificate was a staging certificate a new production certificate will be created.
        - `staging` is true: If not certificate exists or the certificate was a production certificate a new staging certificate will be created.
  - An extra `sites-enabled` file will be used temporarily to create the certificate. (see `roles\deploy-projects\templates\nginx\create-certificate.j2`)
  
2. **Set up Nginx for port 443**:
 - The `roles\deploy-projects\templates\nginx\nginx-html-443.js` takes care of https configuration in Nginx.
 - At this moment there is no default Nginx configuration. This means if you have for example three domains A, B and C pointing to the IP address of you server in their DNS configurations and A listens to port 80, B listens to ports 443 and C is not configured, the following behaviors are to be expected:
     - http://C will show Nginx successful installation message.
     - https://A and https://C will be redirected to https://B. In this scenario B is the first domain which is listening on port 443 and is treated as the default domain.
     - TODO: Setup a default sites-enabled file to get 404 errors in both cases above. For getting this behavior on 443 port you will need to create a not valid self-signed ssl certificate.

3. **Manage certificate renewals**
  - Review `roles\deploy-projects\templates\docker\certbot.j2`.
  - A `certbot-renewal` container will run for each domain with `ssl` set to true. 

##Setting up Your Machine:
1. Follow the setup steps described in Step-1 and Step-2.
2. Add your email address to `env_vars/base.yml` as `certbot_email`
3. Use variables `ssl` and `staging` for your projects in `env_vars/projects.yml`