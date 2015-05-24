FROM centos:latest
MAINTAINER ingktds <tadashi.1027@gmail.com>

ENV PERL_VER="perl-5.20.2" WORK_DIR="/usr/local/src"
RUN yum -y install gcc \
                   make \
                   tar &&\

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
    cpanm Carton

