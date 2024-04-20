1. **Step-1: Basic security settings on the cloud**

    1. **Adding IP to `hosts`**:
        * Add the IP address of your cloud provider (e.g., HETZNER) to the `hosts` file under the group name `[webservers]`.
        
    2. **Installing and setting up a firewall**:
        * Utilize roles for clarity. Refer to the `firewall` folder under roles. Check the `defaults` directory for variables to be used within `tasks/main.yml`. 
        
    3. **Creating a server user, setting up the SSH connection, and implementing other security measures**: 
        * Providing necessary environmental variables. Using `ansible-vault`:
            * Create a folder for environmental variables and add a `base.yml` file, where environment variables such as `server_user`, `server_user_password`, and `ssh_key_file_name` will reside initially.
            * To enhance security, avoid storing passwords and SSH keys in plain text within the Ansible project. Instead, leverage Ansible's vault feature:
                1. Store your vault (strong) password as plaintext in a hidden file named `.secret` within the Ansible project root directory. Exclude this file from version control by adding it to `.gitignore`.
                2. Encrypt your chosen user password for later use on the server. Use the command:
                    ```
                      ansible-vault encrypt_string <YOUR_SERVER_USER_PASSWORD> --vault-pass-file .secret
                    ```
                    
                    * On macOS, you can use:
                    
                    ```
                    ansible-vault encrypt_string <YOUR_SERVER_USER_PASSWORD> --vault-pass-file .secret | pbcopy
                    ```
                3. Paste the encrypted password into `env_files/base.py` as `server_user_password` or replace the dummy one.
        * Utilize a `createuser` role to handle important server setups and changes, such as disabling username and password logins, allowing only SSH connections with a non-root user, and securing SSH communication by using SSH keys.
            1. Generate SSH keys using the `ssh-keygen` command. Place the generated keys in `~/.ssh` and encrypt them similarly to the password.
            2. Copy the encrypted SSH keys to the Ansible project under `roles/createuser/files` and set the `ssh_key_file_name` environmental variable in `env_vars/base.yml`.
            3. Configure tasks in `roles/createuser/tasks/main.yml` for creating the server user, making it a sudoer, adding the SSH public key of your machine to the server's authorized keys, disabling root SSH access, and disabling password access.
            4. Make sure the public ssh key of your local computer can be found under the given path in `\env_vars\base.yml:local_public_ssh_key_path`. This key will be added to authorized keys of your server user.
    4. **Installing docker and git**
       * `base-installations` role has been added and included in `1_setup_webserver.yml`
    		* If you want to use private GitHub respos:
    			1. you need to add the public ssh key of your server to your GitHub account. 
          2. Add your GitHub credentials to `env_vars/base.yml` and uncommit the configurations part in `roles/base-installations/tasks/install_and_configure_git.yml`
          3. It is recommended to have an extra GitHub account only for your projects which you want to deploy on the server. 
          4. You can create a private repository with your usual GitHub account and add your GitHub server account as collaborator to the repository. In this way you have full control over your web projects.
    5. **Creating a Makefile for easier use and documentation reasons**:
        * Using `make` is a good way for saving and reusing commands. Check if it is necessary to install the software on your local machine.
        * Take a look at the `Makefile`

**Step-1 on your machine**:
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
