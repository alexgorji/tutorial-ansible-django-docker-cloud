### Step-4: Deploying a Very Simple Django Project (Without Static Files, Database, and Media)
1. **Add a docker-compose file to the project directory to pull the image of a simple Django project and run a container (role: django-docker-compose)**:
 - The variable `pull_from` sets the path to the Django project's image
 - The variable `wsgi_path` is needed to bind Python's Web Server Gateway Interface to the container's 8000 port using Gunicorn (see `templates\docker\django.j2` in role `deploy-projects`)
2. **Add environmental variables to the docker-compose file for development or production Django settings**:
3. **Set up Nginx for ports 80 and 443 (role: `nginx-sites-enabled-file.yml`)**:

### Setting up Your Machine:
1. Follow the setup steps described in Step-1, Step-2 and Step-3.