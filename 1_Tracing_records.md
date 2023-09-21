# Tracing records

# ============================ matrix_image: 13b49645c630
## basic setting

OS: [registry.suse.com/suse/sle15:15.5](http://registry.suse.com/suse/sle15:15.5) 

Python: 3.10.9 

R: 4.1.3 

conda: 22.11.1 (mambaforge) 

pip: 23.0 

jupyterlab: 3.4.4 

rig: 0.5.3 (macOS and linux) 

renv: 1.0.2 

git: 2.35.3 

ggplot2: 3.4.3

vim: 9.0.1632

# ============================ MATRIX_UPDATE

## ---------------------------- matrix_update: c51f1eacd1a6
## update start for c51f1eacd1a6 

### 1)$ add sudo, version: Sudo 1.9.12p1
zypper install sudo
### 2) add systemctl, version: systemd 249 (249.16+suse.195.gb473c02cc0) ** not used
sudo zypper install systemd

## update end for c51f1eacd1a6

## ---------------------------- matrix_update: 6966f628af29, corresponding to 6966f628af29 in docker, 4.1G
## update start for 6966f628af29
### 1) have the development tools and libraries installed on your system for compiling codes  ** not used
sudo zypper install gcc make autoconf automake libtool pam-devel
### 2) add pamtester: download, configure and make install ** not used
### see: https://pamtester.sourceforge.net
### 3) add SUSEConnect, version: 1.1.0 ** not used, only for registrated paied users
zypper install SUSEConnect
### 4) upgrade jupter notebook, due to error: ModuleNotFoundError: No module named 'jupyter_server.contents' 
pip install --upgrade jupyter notebook
### 5)$ configure the file "/root/.jupyter/jupyter_notebook_config.py" by adding rstudio-server
c.ServerProxy.servers = {
  'rstudio': {
    'command': ['/usr/lib/rstudio-server/bin/rserver', '--www-port={port}'],
    'timeout': 20,
    'launcher_entry': {
      'title': 'RStudio'
    }
  }
}

### 6)$ install npm, for jupyterhub configuration
npm install -g configurable-http-proxy
### 7)$ install jupyterhub
npm install -g configurable-http-proxy
python -m pip install jupyterhub
### 8)$ add users
useradd -m -d /home/test test
passwd test
### 9)$launch jupyterhub, only  jupyter hub can lanuch rstudio, neither jupyter lab and jupyter notebook can. This idea is inspired by: "Hi, I have noticed that when using rocker/binder, it is possible to bypass this issue error and run the amd64 version of RStudio Server on arm mac because RStudio Server is run by jupyter-rsession-proxy.
If you really want to use RStudio Server on arm mac, this workaround may be worth trying." from: https://github.com/rocker-org/rocker-versioned2/issues/144 Rstudio-server could not be accessed via user authentication due to the amd64 version of rsutdio-server for suse although the container in mac is launched via --platoform linux/x86_64. Launch rstudio via jupyterhub is a bypass.
https://www.rocker-project.org/images/versioned/binder.html
jupyterhub --port 8787 --ip 0.0.0.0
## update end for 6966f628af29

## ---------------------------- matrix update for docker afb6d0f21b5e, 11G
## update start for afb6d0f21b5e
### 1) add e2fsprogs for chattr and lsattr function * not used
sudo zypper install e2fsprogs
### 2)$ install snakemake version=7.18.1
mamba install -c conda-forge -c bioconda snakemake==7.18.1
### 3) add unzip and zip in order to install sdk, further to install java, finally to install nextflow
zypper install unzip
zypper install zip
curl -s "https://get.sdkman.io" | bash
source "/root/.sdkman/bin/sdkman-init.sh"
sdk help
unset GREP_OPTIONS;unalias mv;unalias rm
sdk install java # not used, didn't work out
### 4)$ add java in order to use nextflow
sudo zypper --non-interactive install java-17-openjdk-devel
curl -s https://get.nextflow.io | bash
## update end for afb6d0f21b5e, push to docker hub

## How to push images to docker hub
step1: Register a free account in docker hub: https://hub.docker.com, get a username and passwd
step2: docker login # require username and passwd
step3: docker tag matrix_docker matrixin/matrix_docker:v1.0 # (matrixin is the username, v1.0 is the version that is going to be pushed to registry)
step4: docker push matrixin/matrix_docker:v1.0
## How to pull my image
step5: docker pull matrixin/matrix_docker




## ----------------------------

# ============================ ISSUES
## issues
### 1)
### In mac, using platform of "linux/x86_64" instead of "linux/amd64" to build or run a container. 
### the latter one (linux/amd64) will induce problem of installing some R package e.g. "ggplot2"

### 2)
### issue: problem of installing software via zypper
(base) root@5d749335f64a:/home/Desktop/Transcendence/WORKDIR# zypper refresh
Refreshing service 'container-suseconnect-zypp'.
Repository 'SLE_BCI' is up to date.
Building repository 'SLE_BCI' cache .........................................................................................................................................................................[error]
Error building the cache:
[SLE_BCI|https://updates.suse.com/SUSE/Products/SLE-BCI/15-SP5/x86_64/product/] Failed to cache repo (1).
History:
 - 'repo2solv' '-o' '/var/cache/zypp/solv/SLE_BCI/solv' '-X' '/var/cache/zypp/raw/SLE_BCI'
   rpmmd repo type is not supported
   Command exited with status 1.

Skipping repository 'SLE_BCI' because of the above error.
Could not refresh the repositories because of errors.

### reason: this may be casued by conda via the process of "repo2solv"
### solution: I copied the code of repo2solv from the container where zypper works well to the container where zypper didn't work well, it can solve the problem. not sure what happened to the code repo2solv, as it works when the container was initially set up. Probably due to the conda setting as it is the only difference I can tell.

### 3) 
### issue: install Rstudio-server in suse
### how: https://posit.co/download/rstudio-server/
### issue: https://github.com/rstudio/rstudio/issues/2436
### solution: https://posit.co/code-signing/

### 4) 
### build up container, shall be done via interactive, setting to background will not make build successful
### podman run --platform linux/x86_64 --name the_update --volume /Users/jlu:/home -w /home -p 8787:8787 -it c51f1eacd1a6 
### not: podman run --platform linux/x86_64 --name the_update --volume /Users/jlu:/home -w /home -p 8787:8787 -d c51f1eacd1a6 
### podman run --platform linux/x86_64 --name the_update --volume /Users/jlu:/mnt -w /mnt -p 8787:8787 -it c51f1eacd1a6 

### 5)
### podman couldn't mount newjersey locally while docker can, but docker require daemon permission (administration) which is not possilbe to have for common users. 

### 6) 
### When jupyterlab couldn't be accessed via browser, it is probably due to the ip seting
### solution: add --ip argument
jupyter lab --allow-root --port 8787 --no-browser --ip 0.0.0.0


### 7) 
### In order for a user can get acess to mounted directory via Rstudio server
### set the permission of the mounted directory for group to be writing: chmod g+rw /mnt # not working
### set the new user to the group of the mounted directory: sudo usermod -aG nobody test # not working
### changing the permission of group only counldn't solve the issue, becasue the assigned group of the mounted folder is "nobody", and its groupship can not be changed due to permission issue even as root. So I change others as writing for Rstudio to access. I think this is due to the daemon setting in podman. Problems of both unfeasibility to mount newjersey and unfeasibility to change groupship are due to podman daemoless setting?
chmod -R 777 /mnt # not used when transferred to docker from podman
useradd -m -d /home/jlu jlu
passwd jlu -> jlu
sudo usermod -aG nobody jlu


### 8)
### Docker, update docker desttop or reinstall it to solve the daemon privilage issue of docker running in mac.
### how to move podman image to docker-recognizable images
### save podman images to .tar file and load .tar file to docker, then delete the .tar file
podman save -o matrix_update.tar 6966f628af29
docker load -i matrix_update.tar
rm matrix_update.tar

docker run --platform linux/x86_64 --name the_docker --volume /Users/jlu:/mnt/host --volume /Volumes/science/Donertas:/mnt/server -w /home -p 8787:8787 -it 6966f628af29












