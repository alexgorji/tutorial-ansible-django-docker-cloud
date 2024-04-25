This is a step by step ansible tutorial for setting up a cloud server and running a dockerized Django app on it with Nginx. In the last step a backup mechanism will be added.

This tutorial is a work in progress. Please make an issue if you find a bug or have a suggestion!
 
Each step is at the same time a branch of its own. Here is an overview of all steps:


1. **Step-1**: Basic security settings on the cloud
   1. Adding IP to `hosts`
   2. Installing and setting up a firewall
   3. Creating a server user, setting up the SSH connection, and implementing other security measures.
   4. Installing docker and git
   5. Creating a Makefile for easier use and documentation reasons.
   
2. **Step-2**: A very simple html site with Nginx and Docker
   1. Preparations:
     1. Creating a `projects.yml` in `env_vars` and an appropriate playbook `2_deploy_projects.yml`
   
   2. Deploying your first simple web projects.

3. **Step-3**: ssl letsenscript 
  1. Adding certbot certificates to projects (staging or production).
  2. Setting up Nginx for port 443.
  3. Managing certificate renewals.
      
4. **Step-4**: A very simple django project (without static, db and media)
  1. Adding a docker-compose file to the project directory to pull the image of a simple Django project and run a container (role: django-docker-compose).
      * The variable `pull_from` sets the path to the Djangi project's image.
      * The variable `wsgi_path` is needed to bind python's Web Server Gateway Interface to container's 8000 port with aid of gunicorn. (see `templates\docker\django.j2` in role `deploy-projects`)
  2. Adding environmental variables into docker-compose file for development or production Django settings. 
  2. Setting up Nginx for ports 80 and 443 (role: `nginx-sites-enabled-file.yml`)

5. **Step-5**: A demo django project (with static, Postgres db and media)
  1. Using static and media files.
  2. Adding a db service for setting up and using Postgres.
  3. Using `env_files` for setting up Django and Postgres.

6. **Step-6**: Backup
   1. Create backup manually into backup volume
   2. Use cron job for creating backup.
   3. Use GitHub for creating and loading backups.


   
For seeing each step change the branch (e.g. `git checkout Step-1`)