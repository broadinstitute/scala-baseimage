# scala-baseimage

This is a base Docker image for Scala applications that need to run commands with sbt. Useful for development, building, and testing. **Compiled applications shouldn't need this.**

Contains:
* AdoptOpenJDK Java 11
* Scala
* SBT
* Git

This image is built off of the latest AdoptOpenJDK Java 11 image. It is currently published manually.

The current version of the image is here: [broadinstitute/scala-baseimage](https://registry.hub.docker.com/r/broadinstitute/scala-baseimage/)

***N.B. The `latest` tag points to a legacy Java 8 image!***

### Available tags

Java 11:

| Scala   | SBT          | Tag                         |
|---------|--------------|-----------------------------|
| 2.12.11 | 1.4.7        | `jdk11-2.12.11-1.4.7`       |
| 2.12.12 | 1.4.[6/7/9]  | `jdk11-2.12.12-1.4.[6/7/9]` |
| 2.12.13 | 1.4.[7/9]    | `jdk11-2.12.13-1.4.[7/9]`   |
| 2.13.5  | 1.4.7        | `jdk11-2.13.5-1.4.7`        |

Java 8 (Legacy):

| Scala  | SBT     | Tag            |
|--------|---------|----------------|
| 2.12.2 | 0.13.15 | `scala-2.12.2` |
| 2.11.8 | 0.13.12 | `scala-2.11.8` |
| 2.11.7 | 0.13.9  | `latest`       |

(See [build.sh](build.sh))
