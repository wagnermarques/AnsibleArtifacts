FROM fedora:32

MAINTAINER wagnerdocri@gmail.com

#dnf needs proxy config in this way, but wget...
#uncomment accodingly your proxy configuration
ENV http_proxy=http://osinstall:admin123@192.168.0.2:3128/
ENV https_proxy=http://osinstall:admin123@192.168.0.2:3128/

ENV ftp_proxy=http://osinstall:admin123@192.168.0.2:3128/
ENV all_proxy=http://osinstall:admin123*@192.168.0.2:3128/


RUN dnf -y update
RUN dnf -y install R && dnf clean all


