FROM centos:latest
MAINTAINER ingktds <tadashi.1027@gmail.com>

ENV PERL_VER="perl-5.22.0" WORK_DIR="/usr/local/src"
ADD mongodb-org-3.0.repo /etc/yum.repos.d/mongodb-org-3.0.repo
RUN yum -y install gcc \
                   make \
                   tar \
                   mongodb-org &&\

    # Perl Setup
    cd $WORK_DIR &&\
    curl -O http://www.cpan.org/src/5.0/${PERL_VER}.tar.gz &&\
    tar xzf ${PERL_VER}.tar.gz &&\
    cd ${PERL_VER} &&\
    ./Configure -des -Dprefix=/usr/local/ &&\
    make &&\
    make install &&\
    cd $WORK_DIR &&\
    rm -rf ${PERL_VER}* &&\

    # cpanm & Carton setup
    cd /usr/local/bin &&\
    curl -L http://cpanmin.us -o cpanm &&\
    chmod +x cpanm &&\
    cpanm Carton &&\

    # mongoDB setup
    mkdir -p /data/db &&\
    chkconfig mongod on

EXPOSE 27017
ENTRYPOINT ["/usr/bin/mongod"]
