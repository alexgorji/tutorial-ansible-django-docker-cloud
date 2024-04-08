**Step-1**: Basic security settings on the cloud

  1. Adding IP to `hosts`:
    * Add for example the IP address of your cloud (I use HETZNER but you can use any provider of your choice.) to this file under the group name `[webservers]`.
   2. Installing and setting up a firewall:
      * I use roles for more clarity. Take a look at firewall folder under roles. In defaults you find some variables which can be used inside `tasks\main.yml`. I hope it is self explanatory.
   3. Creating a server user, setting up the ssh connection and other security measures: 
      * Before we go on it is necessary to provide some environmental variables and talk about secrets and vaults in Ansible.
        * We will add a folder for environmental vars and add for now a `base.yml` file into it where some of our env vars will live. At this moment these are `server_user`, `server_user_password`, and `ssh_key_file_name`.
        * For security reasons we don't want to add our passwords and ssh-keys in plain text to our ansible project. For this reason we use ansible's vault feature:
          1. Write your vault (strong) password as plaintext to a hidden file named `.secret` in our ansible project root. To avoid pushing this file to GitHub add it to your `.gitignore` file. So you won't be able to see my `.secret` file in this repository!
          2. Decide what user password you want to use when you are logged in your server later (YOUR_PASSWORD). You will be needing it for example when you want to run a sudo command.
          3. To encrypt this password go to the ansible project root (where `.secret` was added) and use the following command: 
          `ansible-vault encrypt_string <YOUR_PASSWORD> --vault-pass-file .secret`
          
          4. Now paste the encrypted password into `env_files/base.py` as `server_user_password` (or replace the dummy one.)
          
      * A createuser role will take care of some important setups and changes on the server. We are for security reasons going to disable username and password logins on the server and allow only ssh connections with a non root user. To be able to communicate via ssh, both your machine and the host need to have a pair of ssh keys (private and public) in users home directory under `~/.ssh`. The host needs to run sshd daemon.
            1. For generating ssh keys we can use the ssh-keygen command: `ssh-keygen -t ed25519 -C "YOUR_COMMNENT"`. The ssh topic goes far beyond the scope of this tutorial so don't worry if you don't understand everything in this command. You will be asked for the path to create the keys.
              * You can pass on a passphrase to encrypt the private key. This is an extra measure to avoid security damages if your private key file is compromised. If you are using a passphrase it would be a good idea to use a ssh-agent in order to not being asked for the passphrase each time the private key is used. At this moment we are not using passphrases to avoid setup complications on the host.
            2. The pair of ssh-keys for your server must be encrypted (like we did with the password) and put into our ansible project under `roles/createuser/files`. You can name your ssh-keys as you like. For ansible to be able to find them it is needed to add the environmental var `ssh_key_file_name` to `env_vars/base.yml`. `roles/createuser/tasks/copy_ssh.yml` will take care of copying both your keys into the host (i.e. your future server) and making the necessary changes.
            3. Under `roles/createuser/tasks/main.yml` you will find all tasks needed for creating the server user with your password, make it a sudoer user, adding the public ssh key of your machine to the authorized keys on the server, disabling root ssh access and disabling the password access. After these setups the only way to login to the server will be a ssh login using your server user and only from your machine. If you wish you can add other authorized keys to the server later. But be careful with it! 
            
**Step-1 on your machine**
After cloning or mirroring this repository following changes must be done to be able to get your own server running:

   1. Copy your cloud's IP address into `hosts`  under [webservers]   
   2. Add the `.secret` file containing a password for ansible vault to the project root.
   3. Encrypt your `server_user_password` as described above.
   4. `env_vars/base.yml`: `server_user`, encrypted `server_user_password` and `ssh_key_file_name`
   5. Generate ssh-keys, encrypt them and add them to `YOUR_SSH_KEY_FILE_NAME` (private) and `YOUR_SSH_KEY_FILE_NAME.pub` (public) in `/rols/createuser/files`
   6. Run the ansible playbook `1_setup_webserver.yml` with this command: `ansible-playbook 1_setup_webserver.yml -u root -i hosts --vault-pass-file .secret`
`
