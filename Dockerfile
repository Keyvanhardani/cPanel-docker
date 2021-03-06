FROM centos:7 
MAINTAINER Keyvan <Keyvan@hardani.de> 

ENV container docker 
ENV hostname fake.dnska.com

RUN yum -y update
RUN yum -y install wget
RUN yum -y install openssh-server

RUN yum -y update
RUN yum -y install wget
RUN yum -y install perl

RUN wget -O /usr/local/src/latest.sh http://httpupdate.cpanel.net/latest
RUN chmod +x /usr/local/src/latest.sh
RUN /usr/local/src/latest.sh --target /usr/local/src/cpanel/ --noexec
RUN sed -i 's/check_hostname();/# check_hostname();/g' /usr/local/src/cpanel/install
RUN touch /etc/fstab
RUN chmod 0640 /etc/fstab
RUN cd /usr/local/src/cpanel/ && ./bootstrap --force

EXPOSE 20 21 22 25 53 80 110 143 443 465 587 993 995 2077 2078 2082 2083 2086 2087 2095 3306
CMD ["/usr/sbin/init"]
