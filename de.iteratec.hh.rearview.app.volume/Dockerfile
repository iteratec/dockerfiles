FROM phusion/baseimage
MAINTAINER nils.kuhn@iteratec.de

ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# install git
RUN sudo apt-get update
RUN sudo apt-get -y install git
# get rearview from git
RUN git clone https://github.com/IteraSpeed/rearview.git --branch v1.0.0-scala --single-branch /app
# create folder for ivy2 cache
RUN mkdir /root/.ivy2
# create volumes
VOLUME /app
VOLUME /root/.ivy2