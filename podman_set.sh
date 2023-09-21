# build image based on Dockerfile [The Dockerfile is in the direcotry: /Users/jlu/Desktop/Transcendence/WORKDIR or the current directory .]

# podman build -t lab_image --platform linux/x86_64 .
podman build -t matrix_image --platform linux/x86_64 .
