# This base image is meant for Scala applications
# And specifically scala web services.  It is build
# using a baseimage that installs runit to launch
# and monitor services.

# http://phusion.github.io/baseimage-docker/
FROM phusion/baseimage

# Cromwell's HTTP Port
ENV TERM=xterm-256color
ENV SCALA_VERSION=2.11.6
ENV SBT_VERSION=0.13.8
ENV JAVA_VERSION=8

# Use baseimage's init system.
CMD ["/sbin/my_init"]

# Install Cromwell
RUN apt-get update && apt-get install -y wget && \
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) multiverse" && \
    add-apt-repository -y ppa:webupd8team/java && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections && \
    apt-get update && \
    apt-get install -y oracle-java${JAVA_VERSION}-installer && \
    wget http://www.scala-lang.org/files/archive/scala-${SCALA_VERSION}.deb && \
    wget http://dl.bintray.com/sbt/debian/sbt-${SBT_VERSION}.deb && \
    dpkg -i scala-${SCALA_VERSION}.deb && \
    dpkg -i sbt-${SBT_VERSION}.deb && \
    apt-get update && \
    apt-get install -y scala sbt && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /*.deb

# Add a service to runit.  runit will make sure the service stays alive
# If it dies, for whatever reason, even a kill -9, it will run the 'run.sh'
# in this example to restart it

#RUN mkdir /etc/service/my_service
#ADD ./run.sh /etc/service/my_service/run
