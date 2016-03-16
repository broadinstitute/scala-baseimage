# scala-baseimage

[![](http://badge-imagelayers.iron.io/broadinstitute/scala-baseimage:latest.svg)](http://imagelayers.iron.io/?images=broadinstitute/scala-baseimage:latest 'Get your own badge on imagelayers.iron.io')

This is a base Docker image for Scala applications, specifically web services.  Currently this image will have installed:

* Java 8
* Scala 2.11.8
* SBT 0.13.9

This image is build off of [baseimage-docker](http://phusion.github.io/baseimage-docker/), which provides an init system and process supervisor called [runit](http://smarden.org/runit/) for starting and monitoring services.

This image is available on Dockerhub ([here](https://registry.hub.docker.com/u/broadinstitute/scala-baseimage/))

## Usage

It is recommended that the `Dockerfile` be located in the root of the project source directory.  This way, the `ADD . /cromwell` line below is a good convention for adding the project source code to the Docker container.

Within the project's source tree are two Docker-related files:

* `docker/install.sh` - A script that is invoked to compile the source code on the container.
* `docker/run.sh` - A script that is invoked by [runit](http://smarden.org/runit/) to start the service.  This is optional.  If scala-baseimage is not being used to host a server then this can be omitted.

```
FROM broadinstitute/scala-baseimage

# Cromwell's HTTP Port
EXPOSE 8000

# Current working directory contains the project source code
ADD . /cromwell
RUN ["/bin/bash", "-c", "/cromwell/docker/install.sh /cromwell"]

# Add Cromwell as a service (it will start when the container starts)
RUN mkdir /etc/service/cromwell
ADD docker/run.sh /etc/service/cromwell/run
```

## Using the Docker Container

Run `docker build .` from this directory to build scala-baseimage.  If it is successful, it'll print out the image ID at the end:

```
$ docker build .
Sending build context to Docker daemon  76.8 kB
Step 0 : FROM phusion/baseimage:0.9.17
 ---> e9f50c1887ea
...
Successfully built a5f889590f04
```

The container is meant to be run in detached mode (`-d` flag for `docker run`).  Scala-baseimage has a proper init system as it's PID 1 process, so the container doesn't immediately exit.

To get a Bash shell on the container:

```
$ docker run -t -i a5f889590f04 bash -l
```

> **NOTE:** This replaces the normal PID 1 process with a `bash -l` process, so any services set up in runit will not run.

To run a persistent container:

```
$ docker run -d a5f889590f04
0623e6ebdfd30d0511b4ee8e56fe32c5d6d99ed436a65b23d1857921822e15f6
```

> **NOTE:** This does start up services set up in runit, but if those services are listening on a port, that port should be exposed via an `EXPOSE <port>` in the Dockerfile as well as a `-p` flag to `docker run`

To get a Bash shell on the prior persistent container:

```
$ docker exec -t -i 0623e6ebdfd30d0511b4ee8e56fe32c5d6d99ed436a65b23d1857921822e15f6 bash -l
```

## Using Runit

The PID 1 process will launch Runit which will in turn start all services that are in `/etc/service`.  This can be better visualized by seeing the process tree within the Docker container:

![scala-baseimage process tree](http://i.imgur.com/sgyIUUR.png)

To control the services, use the `sv` command.  The man pages are available from the container but one might have to do `apt-get update; apt-get install man` to get access to them.

```
# sv status cromwell
run: cromwell: (pid 17) 147672s
# sv down cromwell
# sv up cromwell
```

> ** NOTE:** `sv down` doesn't necessarily kill the underlying Java process.  It might have been orphaned and inherited by PID 1 because it might not respond to signals that Runit is sending it properly.  This would cause a subsequent `sv up` of that service to act weird (e.g. ports would be conflicting).  After doing an `sv down`, if the process isn't dead, kill it with `kill`.
