FROM centos:7 AS openjdk-build

LABEL maintainer="hpmtissera@gmail.com"

RUN yum update -y
RUN yum install -y wget
RUN wget https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz
RUN tar xzf openjdk-11.0.1_linux-x64_bin.tar.gz -C /usr/local
RUN cd /usr/local/jdk-11.0.1
RUN alternatives --install /usr/bin/java java /usr/local/jdk-11.0.1/bin/java 2
RUN alternatives --set java /usr/local/jdk-11.0.1/bin/java
    
RUN wget https://www.mercurial-scm.org/release/centos7/RPMS/x86_64/mercurial-4.9-1.x86_64.rpm
RUN rpm -i mercurial-4.9-1.x86_64.rpm

RUN yum install -y which
RUN yum groupinstall -y "Development Tools"
RUN yum install -y libXtst-devel libXt-devel libXrender-devel libXrandr-devel libXi-devel
RUN yum install -y cups-devel
RUN yum install -y fontconfig-devel
RUN yum install -y alsa-lib-devel

ENV AUTOCONF="/usr/bin/autoconf"