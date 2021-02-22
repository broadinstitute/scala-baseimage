# scala-baseimage

[![](http://badge-imagelayers.iron.io/broadinstitute/scala-baseimage:latest.svg)](http://imagelayers.iron.io/?images=broadinstitute/scala-baseimage:latest 'Get your own badge on imagelayers.iron.io')

This is a base Docker image for Scala applications that need to run commands with sbt. Useful for development, building, and testing. **Compiled applications shouldn't need this.**

* AdoptOpenJDK Java 11
* Scala 2.12.12
* SBT 1.4.7

This image is built off of [the blessed base image](https://github.com/broadinstitute/dsp-appsec-blessed-images/blob/main/jre/Dockerfile.11-debian)

This image is available on Dockerhub ([here](https://registry.hub.docker.com/u/broadinstitute/scala-baseimage/))
