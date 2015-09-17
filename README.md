# scala-baseimage

This is a base docker image for Scala applications, specifically web services.  Currently this image will have installed:

* Java 8
* Scala 2.11.7
* SBT 0.13.9

This image is build off of [baseimage-docker](http://phusion.github.io/baseimage-docker/), which provides an init system and process supervisor called *runit* for starting and monitoring services.

This image is available on Dockerhub ([here](https://registry.hub.docker.com/u/broadinstitute/scala-baseimage/))

An example of a Dockerfile which utilizes this image:

```
FROM broadinstitute/scala-baseimage

# Cromwell's HTTP Port
EXPOSE 8000

# Install Cromwell
ADD . /cromwell
RUN ["/bin/bash", "-c", "/cromwell/docker/install.sh /cromwell"]

# Add Cromwell as a service (it will start when the container starts)
RUN mkdir /etc/service/cromwell
ADD docker/run.sh /etc/service/cromwell/run
```
