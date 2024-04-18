This is a step by step ansible tutorial for setting up a server on cloud and running a dockerized Django app on it with Nginx. In the last step a backup mechanism will be added.

 
Each step is at the same time a branch of its own. Here is an overview of all steps:


1. **Step-1**: Basic security settings on the cloud
   1. Ansible configurations
   2. Installing and setting up a firewall
   3. Creating a server user, setting up the ssh connection and other security measures.
   4. Creating a Makefile for easyier use and documentation reasons.
3. **Step-2**: A very simple html site with Nginx and Docker
   1. Nginx configuration.
   1. Using docker compose and volume
3. **Step-3**: ssl letsenscript 
   1. Staging for test reasons.
   2. Adding a real certificate.
4. **Step-4**: A very simple django project (without static, db and media)
   1. Nginx configuration.
   2. Using docker compose and volume
   3. Adding a certificate.
5. **Step-5**: A simple demo django project (with static, db and media)
   1. Nginx configuration.
   2. Using docker compose and volume
6. **Step-6**: Backup
   1. Create backup manually into backup volume
   2. Use cron job for creating backup.
   3. Install and configure git
   2. Use GitHub for creating and loading backups.
   
For seeing each step change the branch (e.g. `git checkout Step-1`)