as-root-user-webservers:
	ansible-playbook 1_setup_webserver.yml -u root -i hosts --vault-pass-file .secret
as-admin-user-webservers:
	ansible-playbook 1_setup_webserver.yml -u <YOUR_SERVER_USERNAME> -i hosts --vault-pass-file .secret
