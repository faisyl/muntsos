FROM debian:11
MAINTAINER Faisal <faisal@pruxi.in>

RUN apt-get update -y  && apt-get install -y openssh-client build-essential git gprbuild wget sudo

RUN \
  wget http://repo.munts.com/debian11/PublicKey.txt && apt-key add PublicKey.txt && rm PublicKey.txt &&\
  wget http://repo.munts.com/debian11/amd64/munts-repo.deb && dpkg -i munts-repo.deb && rm munts-repo.deb &&\
  apt-get -y update &&\
  apt install -y openssh-client build-essential git gnat gprbuild libncurses5 man

RUN \
  apt install -y muntsos-dev

RUN apt install -y flex bison libncurses-dev libssl-dev bc dos2unix cpio vim cmake
RUN apt install -y autoconf autogen automake build-essential  pkg-config python3 libtool zip unzip
