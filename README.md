# Python Intro — Dev Container and Setup

This project contains a Jupyter notebook and a development container configuration to make it easy to run and reproduce locally.

Quick start

1. Open the folder in VS Code.
2. When prompted, reopen in container (or use the Command Palette: Remote-Containers: Reopen in Container).
3. The container will run `./setup_env.sh` automatically to install Python dependencies from `requirements.txt`.

Make the setup script executable (if needed):

```bash
chmod +x "./setup_env.sh"
```

Git: create local repo and push to remote

```bash
# initialize local git repo
git init
git add .
git commit -m "Initial commit: add devcontainer and requirements"

# add remote and push (replace origin url if needed)
git remote add origin https://github.com/jorgermzg15/python-intro.git
git branch -M main
git push -u origin main
```

If your remote repository is empty, the commands above will create the `main` branch and push the initial commit.
