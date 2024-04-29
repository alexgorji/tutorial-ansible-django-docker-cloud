### Step-4: Deploying a Very Simple Django Project (Without Static Files, Database, and Media)
1. **Add a `docker-compose-django` file to the project directory to pull the image of a simple Django project and run a container (role: `django-docker-compose`)**:
 - The variable `pull_from` sets the path to the Django project's image
 - The variable `wsgi_path` is needed to bind Python's Web Server Gateway Interface to the container's 8000 port using Gunicorn (see `templates\docker\django.j2` in role `deploy-projects`)
2. **Add an `env_file to` the `docker-compose-django` file for development or production Django settings**:
 - The Django docker image must contain a python file named: `create-key.py` for creating a secret key on the server (see `roles/deploy-projects/template/docker/django.j2`).
 - Other setting environments variables like `DEBUG`, `ALLOWED_HOSTS`, `TIME_ZONE` etc. can be set inside an `env_file`. (see `project_files/simple-django-project/env.dev`). The path to this file must be set for the project in `env_vars/projects.yml`. So you can have more than one env_file for example for development and production. The environmental variable `SECRET_KEY` must be set from inside the container with the aid of project's own `create-key.py` file.
3. **Set up Nginx for ports 80 and 443 (role: `nginx-sites-enabled-file.yml`)**:
  - At this stage we still don't need to set any `static` or `media` urls within the Nginx config file.
### Setting up Your Machine:
1. Follow the setup steps described in Step-1, Step-2 and Step-3.
2. Set project's variables within `env_vars/projects.yml`. The new variables are: 
  - `pull_from` for the path to the docker image of your Django project.
  - `wsgi_path` of you Djnago project. This is usually set to `<UNDERLINED_PROJECT_NAME>.wsgi`
  - The path to your `env_file`. You can put your files into `project_files/<PROJECT_NAME>`