FROM adoptopenjdk:11-jdk-hotspot

ENV SCALA_VERSION=2.12.12 \
    SBT_VERSION=1.4.7

# Setup adapted from https://github.com/hseeberger/scala-sbt/blob/master/debian/Dockerfile

RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update -q && \
  apt-get upgrade -qq && \
  apt-get install -y git && \
  rm -rf /var/lib/apt/lists/*

RUN \
  mkdir /setup-project && \
  cd /setup-project && \
  echo "scalaVersion := \"${SCALA_VERSION}\"" > build.sbt && \
  sbt sbtVersion scalaVersion && \
  rm -rf /setup-project
