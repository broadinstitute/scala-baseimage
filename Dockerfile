FROM adoptopenjdk:11-jdk-hotspot

# Setup adapted from https://github.com/hseeberger/scala-sbt/blob/master/debian/Dockerfile
RUN \
  apt-get update -q && \
  apt-get upgrade -qq && \
  apt-get install -y git && \
  rm -rf /var/lib/apt/lists/*

# Any RUN command after an ARG is set has that value in it as an environment variable and thus
# invalidates layer cache, so only declaring these ARGs when they're used

ARG SBT_VERSION
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb

ARG SCALA_VERSION
RUN \
  mkdir /setup-project && \
  cd /setup-project && \
  echo "scalaVersion := \"${SCALA_VERSION}\"" > build.sbt && \
  echo "case object Temp" > Temp.scala && \
  sbt compile && \
  rm -rf /setup-project

ENTRYPOINT "bash"
