# scala-baseimage

This is a base Docker image for Scala applications that need to run commands with sbt. Useful for development, building, and testing. **Compiled applications shouldn't need this.**

Contains:
* AdoptOpenJDK Java 11
* Scala
* SBT
* Git

This image is built off of the latest AdoptOpenJDK Java 11 image.

The current version of the image is here: [us.gcr.io/broad-dsp-gcr-public/scala-baseimage](https://us.gcr.io/broad-dsp-gcr-public/scala-baseimage)

The image on Dockerhub ([here](https://registry.hub.docker.com/r/broadinstitute/scala-baseimage/)) is the legacy JDK 8 image.

### Available tags

| Scala   | SBT   | Tag                   |
|---------|-------|-----------------------|
| 2.12.11 | 1.4.7 | `jdk11-2.12.11-1.4.7` |
| 2.12.12 | 1.4.6 | `jdk11-2.12.12-1.4.6` |

(See [build.sh](build.sh))
