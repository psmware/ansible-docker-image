# Ansible Docker Image
This project builds a Docker image containing the current stable Ansible 2.9.6. During the build the container installs everything from the `requirements` folder. A non-root user `coder` is included to allow for non-root development.

## Building the Docker image

To build the image run `make build` int he project root. You can edit the Makefile to create your own image names.

```zsh
-> ansible-docker-image $ make build
docker build -t psmware/ansible-docker:1.1 --no-cache --rm .
Sending build context to Docker daemon  120.8kB
Step 1/17 : FROM python:3.7-alpine3.10

 << snipped output >>

Successfully built <<random guid here>>
Successfully tagged psmware/ansible-docker:1.1
-> ansible-docker-image $ 
```
