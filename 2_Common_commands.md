  #### Common commands
  ### Images
  conda env list # list all environments
  conda info --envs # list all environments
  podman -h # help
  cd /Users/jlu/Desktop/Transcendence/WORKDIR/ # change directory
  podman build -t lab_image --platform linux/x86_64 . # build image
  podman ps --all # list all containers
  podman images # list all images
  podman rmi f682eb0f2ad6 # remove image
  podman rmi -f 7881442987bf # remove image
  podman images # list all images
  podman ps -a # list all containers
  podman stop 87844eb3124d # stop container
  podman images # list all images
  
  sh podman_set.sh
  podman ps #  list all containers
  # or
  podman container ls #  list all containers
  podman comit 6240a134e2ea suse_lab #  commit container to image 

  ### Container
  podman run --platform=linux/x86_64 -it localhost/lab_image # run container
  podman rm container_id # remove a container
  # or
  podman run  --platform linux/amd64 -it c9de6e62800b # run container

  podman run -dt  --platform linux/amd64 c9de6e62800b bash # run container
  podman exec -it charming_edison bash # enter container
  podman ps #  list all containers
  podman stop charming_edison # stop container
  podman ps #  list all containers
  podman ps --all #  list all containers
  podman start charming_edison # start container
  podman ps # list all containers
  podman exec -it charming_edison bash # enter container

  podman container ls
  podman container ls --all


## 
  podman machine stop
  podman machine start
  podman run --platform linux/amd64 --name the_matrix -it c9de6e62800b
  podman run --platform linux/amd64 --name the_matrix --volume /Users/jlu:/home -it c9de6e62800b

  # podman run --platform linux/amd64 --name the_matrix --volume /Users/jlu:/home --volume /Volumes/science/Donertas:/mnt -w /home -it c9de6e62800b 
  # podman run --platform linux/amd64 --name the_matrix --mount type=bind,src=/Users/jlu,target=/home --mount type=bind,src=/Volumes/science/Donertas,target=/mnt -w /home -it c9de6e62800b 

## official
  # podman run --platform linux/amd64 --name the_matrix --volume /Users/jlu:/home -d c9de6e62800b # didn't work. container could not be started

  # podman run --platform linux/amd64 --name the_matrix --volume /Users/jlu:/home -w /home -it c9de6e62800b

  podman start the_matrix

  podman exec -it the_matrix bash

  ssh jlu@gen100.leibniz-fli.de

# in mac of arm64-based silicon cpu (M1), alothough both --platform linux/amd64 and linux/x86_64 can access to the container, only linux/x86_64 can ggplot2 be installed successfully. When having error message of "ggplot2 could not be load" while installing "ggplot2", that is because of the enviroment configuration in the /home, solution would be to install gglot2 in other folder.
 podman run --platform linux/x86_64 --name the_matrix --volume /Users/jlu:/home -w /home -it 13b49645c630
 cd /root
 install ggplot2
 zypper install man
# add port
podman run --platform linux/x86_64 --name the_update --volume /Users/jlu:/home -w /home -p 8787:8787 -it c51f1eacd1a6 
# update
podman run --platform linux/x86_64 --name the_update --volume /Users/jlu:/mnt -w /mnt -p 8787:8787 -it c51f1eacd1a6 
# launch jupyter lab via browser
jupyter lab --allow-root --port 8787 --no-browser --ip 0.0.0.0


# in server
podman run --runtime crun --annotation=run.oci.keep_original_groups=1 --name the_matrix -v /wins/donertas:/wins -w /wins -it caa358743144

podman start the_matrix
podman ps
podman exec -it the_matrix bash



