Dockerized Jepsen
=================

## Prerequisites
- OpenSSH client (to generate an ssh key to login to the container)

## Usage
This docker image attempts to simplify the setup required by Jepsen.
It is intended to be used by a CI tool or anyone with docker who wants to try jepsen themselves.

It contains all the jepsen dependencies and code. It uses [Docker Compose](https://github.com/docker/compose) to spin up the five
containers used by Jepsen.  

To start, run

````
    ./up.sh
````

This will build 5 Jepsen node containers and a single control container. It
will then bring these containers up and mount the jepsen code into the
containers at `/jepsen`.You'll then get dropped into a shell in the control
container in the directory that `jepsen` code is mounted in.

Verify everything has been set up properly by running,
`cd etcd && lein test --concurrency 10`.

To bring the containers down, run
````
  docker-compose down
````

To bring the containers down and prune the images, run
````
  docker-compose down --rmi all
````

