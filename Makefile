as-root-user-webservers:
	ansible-playbook 1_setup_webserver.yml -u root -i hosts --vault-pass-file .secret
as-admin-user-webservers:
	ansible-playbook 1_setup_webserver.yml -u <SERVER_USER_NAME> -i hosts --vault-pass-file .secret
