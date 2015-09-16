FROM centos:latest
MAINTAINER ingktds <tadashi.1027@gmail.com>

RUN yum -y install openssh-server \
                   gcc \
                   make \
                   tar &&\
    # Perl Setup
    curl -O http://www.cpan.org/src/5.0/perl-5.22.0.tar.gz &&\
    tar xzf perl-5.22.0.tar.gz &&\
    cd perl-5.22.0 &&\
    ./Configure -des -Dprefix=/usr/local/ &&\
    make &&\
    make install &&\
    rm -rf perl-5.22.0* &&\
    # cpanm & Carton setup
    cd /usr/local/bin &&\
    curl -L http://cpanmin.us -o cpanm &&\
    chmod +x cpanm &&\
    cpanm Carton

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
