FROM centos:latest

MAINTAINER jeroen@jeroenvd.nl

RUN yum update -y
RUN (yum install -y yum-utils yum-priorities vim-minimal subversion curl zip unzip || yum install -y yum-utils yum-priorities vim-minimal subversion curl zip unzip)
RUN yum install telnet wget -y
#RUN sudo setenforce 0
RUN cd /tmp && wget https://github.com/mustafaramadhan/kloxo/raw/rpms/release/neutral/noarch/mratwork-release-0.0.7-9.noarch.rpm --no-check-certificate
RUN cd /tmp && rpm -ivh mratwork-release-0.0.7-9.noarch.rpm
RUN cd / && yum clean all && yum update mratwork-* -y
RUN yum install kloxomr7 -y
RUN sh /script/upcp
