### Step-5: Deploying a Demo Django Project (With Static Files, SQLLite/Postgres Database, and Media)

1. **Add staticfiles' path to backend service**:
   - Mount the path `{{ sites_path }}/var/www/{{ domain }}/staticfiles` on the server into the backend container at `/var/www/app/staticfiles`.
   - Assumption: `STATIC_ROOT` in the Django project's settings is set to `BASE_DIR / 'staticfiles'`, and its `Dockerfile` sets `WORKDIR` to `/var/www/app/` and creates `/var/www/app/staticfiles`.

2. **Add a media volume to backend service if needed**:
   - If the project's variable `media_volume` is true, add a volume to the Docker Compose file for backing up uploaded files. Uploaded media files will remain existing in a volume named `media_volume-<PROJECT_NAME>` in case domain files are deleted on the server. To remove all files, remove this volume on the server.

3. **Setup Nginx service and update configuration files to use static and media files**:
   - Add two locations to Nginx configuration files to serve static and media files.

4. **Add a db service for using postgres**:
   - Add a db service to the Docker Compose file if the variable `postgres` is set to `true`.

5. **Use env_files for setting up database settings in Django settings and postgres container**:
   - To use Postgres, certain settings are needed inside the Django project and for the Postgres container. Refer to `project_files\<PROJECT_NAME-6>/env.dev`.

### Setting up Your Machine:
1. Follow the setup steps described in Step-1, Step-2, Step-3, and Step-3.
2. Set variables `media_volume` and `postgres` to `true` if needed.
3. Set appropriate environmental variables in `env_file` if needed.
  - If you are using postgres the following variables must be set: `SQL_ENGINE=django.db.backends.postgresql, SQL_DATABASE=<DATABASE_NAME>, SQL_USER=<YOUR_DB_USER>, SQL_PASSWORD=<YOUR_DB_PASSWORD>, SQL_HOST=db-<PROJECT_NAME> SQL_PORT=5432`
  - This settings in Django are assumed:
    
    ```
    DATABASES = {
        "default": {
            "ENGINE": os.environ.get("SQL_ENGINE", "django.db.backends.sqlite3"),
            "NAME": os.environ.get("SQL_DATABASE", BASE_DIR / "db.sqlite3"),
            "USER": os.environ.get("SQL_USER", "user"),
            "PASSWORD": os.environ.get("SQL_PASSWORD", "password"),
            "HOST": os.environ.get("SQL_HOST", "localhost"),
            "PORT": os.environ.get("SQL_PORT", "5432"),
        }
    }
    ```
    
  - For postgres container: `POSTGRES_USER=<YOUR_DB_USER>`, `POSTGRES_PASSWORD=<YOUR_DB_PASSWORD>`, `POSTGRES_DB=<DATABASE_NAME>`
