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
     1. Creating a `projects.yml` in `env_vars` and an appropriate playbook `2_install_projects.yml`
   
   2. Installing two simple html projects.
   		1. Cloning a private or public git repository with a simple html file into `~/sites` path
     	2. Running an Nginx container with docker compose to deploy the simple html site on `<YOUR_SIMPLE_HTML_DOMAIN>`
          
3. **Step-3**: ssl letsenscript 
   		1. Staging for test reasons.
   		2. Adding a real certificate.
      
4. **Step-4**: A very simple django project (without static, db and media)
   		1. Cloning a private or public git repository with a very simple Django project into `~/sites` path
   		2. Running an Nginx container with docker compose to deploy the simple Django site on `<YOUR_SIMPLE_DJANGO_DOMAIN>`:
     		1. Nginx configuration.
     		2. Using docker compose and volume
   		3. Adding a certificate.

5. **Step-5**: A simple demo django project (with static, postgres db and media)
   * Adding the environmental variables to `projects.yml` for each step.)
   		1. Cloning a private or public git repository with a very simple Django project into `~/sites` path
   		1. Nginx configuration.
   		2. Using docker compose and volume

6. **Step-6**: Backup
   (Adding the environmental variables to `projects.yml` for each step.)
   1. Create backup manually into backup volume
   2. Use cron job for creating backup.
   3. Install and configure git
   2. Use GitHub for creating and loading backups.


   
For seeing each step change the branch (e.g. `git checkout Step-1`)