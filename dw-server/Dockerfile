FROM centos:centos6
MAINTAINER Shen Xinyu <xinyu.shen@funplus.com>

WORKDIR /root
#for nginx
RUN rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm

#for php
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

#install software
RUN yum -y install nginx openssh-server python-setuptools mysql-server mysql git wget
RUN yum -y --enablerepo=remi install php php-common php-cli php-fpm php-mysqlnd php-mbstring redis php-redis beanstalkd
RUN easy_install supervisor

#install phpunit
RUN wget https://phar.phpunit.de/phpunit.phar && \
    chmod +x phpunit.phar && \
    mv phpunit.phar /usr/bin/phpunit

#add ssh account
RUN /etc/init.d/sshd start
RUN echo 'root:funplus' | chpasswd
## Set up SSHD config
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

#add mysql account and init db
RUN /etc/init.d/mysqld start && \
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by '';" && \
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by '';" && \
    mysql -e "grant all privileges on *.* to 'hellofarm'@'%' identified by 'halfquestfarm4321';" && \
    mysql -e "grant all privileges on *.* to 'hellofarm'@'localhost' identified by 'halfquestfarm4321';"

#deal conf
RUN sed -i -e 's/^user = apache/user = root/g' \
           -e 's/^group = apache/group = root/g' /etc/php-fpm.d/www.conf
RUN sed -i -e 's/^upload_max_filesize = 2M/upload_max_filesize = 300M/g' \
           -e 's/^max_file_uploads = 20/max_file_uploads = 2048/g' /etc/php.ini
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY actord.cf /root/actord.cf
COPY supervisord.conf /etc/supervisord.conf
COPY init.sh /root/init.sh
COPY actord.sh /root/actord.sh

EXPOSE 22 80 8001
CMD ["/root/init.sh"]
