FROM poklet/centos-baseimage

MAINTAINER jeroen@jeroenvd.nl

RUN mkdir /build
ADD build/runit /build/runit
RUN /build/runit/install.sh

RUN (yum update -y || yum update -y)
RUN (yum install -y git yum-utils yum-priorities vim-minimal subversion curl zip unzip || yum install -y git yum-utils yum-priorities vim-minimal subversion curl zip unzip)
RUN (yum install telnet wget -y || yum install telnet wget -y)
#RUN sudo setenforce 0
RUN cd /tmp && wget https://github.com/mustafaramadhan/kloxo/raw/rpms/release/neutral/noarch/mratwork-release-0.0.7-9.noarch.rpm --no-check-certificate
RUN cd /tmp && rpm -ivh mratwork-release-0.0.7-9.noarch.rpm
RUN cd / && yum clean all && yum update mratwork-* -y

# Git clone scripts repo
RUN cd / && git clone https://github.com/appdesign1987/scripts.git

# Make sure scripts are executable
RUN cd /scripts && chmod +x *.sh

EXPOSE 22 21 80 7778 3306 443 25 993 110

#Start app                                                                                                                                                                                                  
CMD runit
