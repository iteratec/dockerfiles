FROM 1science/sbt:0.13.8-oracle-jre-7
MAINTAINER Nils Kuhn <nils.kuhn@iteratec.de>

# prepare apt to work noninteractively
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

RUN rm /app/RUNNING_PID

EXPOSE 9000 8888

ADD entrypoint.sh /root/entrypoint.sh
RUN chmod u+x /root/entrypoint.sh
CMD /root/entrypoint.sh