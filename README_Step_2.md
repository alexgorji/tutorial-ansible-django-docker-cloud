### Step-2: Deploying a Very Simple HTML Site with Nginx and Docker

1. **Preparations**:
   - A `projects.yml` file has been added to `env_vars` and an appropriate playbook `2_deploy_projects.yml` has been created.
     - `projects.yml` is where you list all the web projects you're deploying. Each project will have its own directory structure within the `sites_path` set in `env_vars/base.yml`, following the format: `<site_path>/<domain>/<name>`.
     - You can utilize private or public git repositories to transfer project code if needed. At this stage, only static HTML projects use git. In this case, the repository will be cloned into your project path.

2. **Deploying Your First Simple Web Projects**:
   - Review `projects.yml` to determine the required variables.
   - An Nginx container with Docker Compose is setup and run (refer to roles: nginx-config).
   - `deploy-projects`:
     1. Tasks `git`:
        * Clones a private or public git repository containing a simple HTML file into your sites path.
        * Demo public repositories will be used for this tutorial.
        * If not logged in as a GitHub user or lack SSH access to GitHub, clone repositories via HTTPS web URL.
        * For GitHub SSH access, add the server's public key to your GitHub account.
     2. Tasks `copy-html-folder`:
        * Copies the HTML directory of each project into the Nginx container. This is the simplest method to run test HTML sites.
     3. Tasks `nginx-sites-enabled-file`:
        * Adds an appropriate Nginx configuration file to sites-enabled for each web project.
   - Role `clean-docker`:
      * Performs simple container cleaning.
   - Role `remove-projects`:
      * Stops Docker containers and removes project files from disk if `state` is set to absent.

##Setting up Your Machine:
1. Follow the setup steps described in Step-1.
2. Replace `<YOUR_SERVER_USERNAME>` in the `Makefile` with your server username.
3. Add your `<PROJECT_NAME>` and `<DOMAIN>` to `/env_vars/projects.yml`.
4. You can set `status` to absent to stop Docker containers and remove all files of a project.
5. To deploy the project, run:
