FROM centos:latest
MAINTAINER ingktds <tadashi.1027@gmail.com>

ENV WORKDIR="/root"
RUN cd $WORKDIR
RUN yum -y install gcc make git bzip2 tar patch
RUN git clone https://github.com/tagomoris/xbuild.git
RUN xbuild/perl-install 5.24.0 ${WORKDIR}/local/perl-5.24
ENV PATH ${WORKDIR}/local/perl-5.24/bin:$PATH
