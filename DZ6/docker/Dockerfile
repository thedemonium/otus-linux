FROM centos:centos7
MAINTAINER Efimov Valentin <vefimov@gifts.ru>

RUN yum -y install openssl

# install repo for centos
# epel repo
RUN rpm -Uvh http://rust.komposerv.ru/otus/repo/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm

# expose HTTP
EXPOSE 80

# Run
CMD [ "/usr/sbin/nginx" ]