### Step-1: Basic Security Settings on the Cloud

1. **Add IP to `hosts`**:
   - Include the IP address of your cloud provider (e.g., HETZNER) in the `hosts` file under the `[webservers]` group.

2. **Install and Configure a Firewall**:
   - For clarity, utilize roles. Refer to the `firewall` folder under roles and check the `defaults` directory for variables to be used within `tasks/main.yml`.

3. **Create a Server User, Set Up SSH Connection, and Implement Other Security Measures**:
   - Define necessary environmental variables under `\env_vars\base.yml` and use `ansible-vault`:
     - Store environment variables like `server_user`, `server_user_password`, and `ssh_key_file_name` in `\env_vars\base.yml`.
     - Enhance security by avoiding plain text storage of passwords and SSH keys. Instead, leverage Ansible's vault feature:
       1. Store the vault password as plaintext in a hidden file named `.secret` within the Ansible project root directory (exclude from version control).
       2. Encrypt the chosen user password for server use:
          ```
          ansible-vault encrypt_string <YOUR_SERVER_USER_PASSWORD> --vault-pass-file .secret
          ```
          * On macOS, use:
          ```
          ansible-vault encrypt_string <YOUR_SERVER_USER_PASSWORD> --vault-pass-file .secret | pbcopy
          ```
       3. Paste the encrypted password into `env_files/base.py` as `server_user_password`, or replace the placeholder.
   - Utilize the `createuser` role for essential server setups and changes, such as:
     - Disabling username and password logins.
     - Allowing only SSH connections with a non-root user.
     - Securing SSH communication by using encrypted SSH keys.
     - Generate SSH keys using `ssh-keygen` and encrypt them.
     - Copy the encrypted SSH keys to the Ansible project under `roles/createuser/files` and set the `ssh_key_file_name` environmental variable in `env_vars/base.yml`.
     - Ensure the public SSH key of your local computer is in `\env_vars\base.yml:local_public_ssh_key_path`, which will be added to authorized keys of your server user.

4. **Install Docker and Git**:
   - The `base-installations` role has been added and included in `1_setup_webserver.yml`.
   - For private GitHub repos:
     1. Add the public SSH key of your server to your GitHub account.
     2. Add GitHub credentials to `env_vars/base.yml` and uncomment the configurations part in `roles/base-installations/tasks/install_and_configure_git.yml`.
     3. It's recommended to have a separate GitHub account only for server projects, and add it as a collaborator to your private repository for full control.
     4. Create a private repository with your usual GitHub account and add your GitHub server account as a collaborator to maintain control over your web projects.

5. **Create a Makefile for Easier Use and Documentation Purposes**:
   - Utilizing `make` is beneficial for saving and reusing commands. Ensure necessary software is installed on your local machine.
   - Review the `Makefile`.

### Step-1 on Your Machine:
After cloning or mirroring this repository, follow these steps to set up your server:

1. Copy your cloud provider's IP address into the `hosts` file under the `[webservers]` group.
2. Add a `.secret` file containing a password for Ansible vault to the project root.
3. Encrypt your `server_user_password`.
4. Update `env_vars/base.yml` with `server_user`, the encrypted `server_user_password`, `local_public_ssh_key_path`, and `ssh_key_file_name`.
5. Generate SSH keys, encrypt them, and add them to `/roles/createuser/files/YOUR_SSH_KEY_FILE_NAME` (private) and `/roles/createuser/files/YOUR_SSH_KEY_FILE_NAME.pub` (public).
6. Execute the Ansible playbook `1_setup_webserver.yml` using the command:
    ```
    make as-root-user-webservers
    ```
7. If necessary, remove the cloud provider's IP address from known keys with the command: `ssh-keygen -R <IP>`.
8. You can now access the server via SSH using: `ssh <YOUR_SERVER_USERNAME>@
