as-root-user-webservers:
	ansible-playbook 1_setup_webserver.yml -u root -i hosts --vault-pass-file .secret
