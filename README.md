## Step-by-Step Ansible Tutorial: Setting up a Cloud Server and Running a Dockerized Django App with Nginx

This tutorial provides step-by-step instructions for setting up a cloud server and deploying a Dockerized Django application with Nginx. In the final step, a backup mechanism will be implemented.

**Note:** This tutorial is a work in progress. Feel free to create an issue if you find a bug or have a suggestion!

Each step corresponds to a separate branch. Here's an overview of all steps:

1. **Step-1: Basic Security Settings on the Cloud**
   - Add IP to `hosts`
   - Install and configure a firewall
   - Create a server user, set up the SSH connection, and implement other security measures
   - Install Docker and Git
   - Create a Makefile for easier use and documentation purposes

2. **Step-2: Deploying a Very Simple HTML Site with Nginx and Docker**
   - **Preparations:**
     - Create a `projects.yml` in `env_vars` and an appropriate playbook `2_deploy_projects.yml`
   - Deploy your first simple web project

3. **Step-3: SSL Let's Encrypt Setup**
   - Add Certbot certificates to projects (staging or production)
   - Set up Nginx for port 443
   - Manage certificate renewals

4. **Step-4: Deploying a Very Simple Django Project (Without Static Files, Database, and Media)**
   - Add a docker-compose file to the project directory to pull the image of a simple Django project and run a container (role: django-docker-compose)
     - The variable `pull_from` sets the path to the Django project's image
     - The variable `wsgi_path` is needed to bind Python's Web Server Gateway Interface to the container's 8000 port using Gunicorn (see `templates\docker\django.j2` in role `deploy-projects`)
   - Add environmental variables to the docker-compose file for development or production Django settings
   - Set up Nginx for ports 80 and 443 (role: `nginx-sites-enabled-file.yml`)

5. **Step-5: Deploying a Demo Django Project (With Static Files, Postgres Database, and Media)**
   - Use static and media files
   - Add a database service for setting up and using Postgres
   - Use `env_files` for setting up Django and Postgres

6. **Step-6: Backup Mechanism**
   - Create backups manually into a backup volume
   - Use cron jobs for creating backups
   - Utilize GitHub for creating and loading backups

To view each step, change the branch (e.g., `git checkout Step-1`).
