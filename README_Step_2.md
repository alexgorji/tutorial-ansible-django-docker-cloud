**Step-2**: A very simple html site with Nginx and Docker
   
   1. Preparations:
     1. Creating a `projects.yml` in `env_vars` and an appropriate playbook `2_deploy_projects.yml`
       * `projects.yml` is the place where you can add all your web projects which you are going to deploy. This file will be looped over in `2_deploy_projects.yml`
       * You can use a private or public git repository to transfer your project's code. In this case the repository will be cloned into your sites path on the server.
       * You can change your sites path in `env_vars/base.yml`. 
       
   2. Deploying your first web project.
   		* (Adding the environmental variables to `projects.yml` for each step.)
   		
	1. Cloning a private or public git repository with a simple html file into your sites path (see role: git)
     	* We will use demo public repos for this tutorial.
      * If you are not logged in as a GitHub user and have no ssh access to GitHub you have to clone the repos via https web URL.
   	2. Running an Nginx container with docker compose to deploy the simple html site on `<YOUR_SIMPLE_HTML_DOMAIN>` (see roles: nginx-config and docker):
   		1. Nginx config files
     	2. Using `volume` to mount the html file into the Nginx container.
      3. The created `docker-compose.yml` file and the Nginx config file (see `roles/nginx-config/template/nginx-html-80.j2` and `roles/docker/templates/html-80.j2`) expect to find an `html` folder containing an `index.html` file in the project root folder.

**Step-1 and Step-2 on your machine**:
After cloning or mirroring this repository, follow these steps to set up your server:

1. Copy your cloud provider's IP address into the `hosts` file under the `[webservers]` group.
2. Add a `.secret` file containing a password for Ansible vault to the project root.
3. Encrypt your `server_user_password` as described above.
4. Update `env_vars/base.yml` with `server_user`, the encrypted `server_user_password`, `local_public_ssh_key_path` and `ssh_key_file_name`.
5. Generate SSH keys, encrypt them, and add them to `/roles/createuser/files/YOUR_SSH_KEY_FILE_NAME` (private) and `/roles/createuser/files/YOUR_SSH_KEY_FILE_NAME.pub` (public).
6. Execute the Ansible playbook `1_setup_webserver.yml` using the command:
    ```
    ansible-playbook 1_setup_webserver.yml -u root -i hosts --vault-pass-file .secret
    ```
    or if you created the `Makefile`:
    ```
    make as-root-user-webservers
    ```
7. If necessary, remove the cloud provider's IP address from known keys with the command: `ssh-keygen -R <IP>`.
8. You can now access the server via SSH using: `ssh <YOUR_SERVER_USERNAME>@<IP>`.
  
**Step-2**

1. Change `sites_path` in `env_vars/base.yml` if needed.
2. Add GitHub credentials to `env_vars/base.yml` and uncomment the configuration part in `/roles/base_installations/tasks/install_and_configure_git.yml` if needed.
3. Replace `<YOUR_SERVER_USERNAME>` in the `Makefile` with your server username.
4. Add your `<PROJECT_NAME>` and `<DOMAIN>` to `/env_vars/projects.yml`
5. You can your `status` absent to stop docker containers and removing all files.
6. To deploy the project run:

	```
	make as-admin-user-projects
	```