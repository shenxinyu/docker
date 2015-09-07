FROM centos:centos6
MAINTAINER Shen Xinyu <xinyu@home.sina.net>

WORKDIR /root
#for nginx
#RUN rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm

#for php
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

#install software
RUN yum -y install nginx openssh-server python-setuptools mysql-server mysql git wget tar
RUN yum -y --enablerepo=remi install php php-common php-cli php-fpm php-mysqlnd php-mbstring redis php-redis php-devel

#install phpunit
RUN wget https://phar.phpunit.de/phpunit.phar && \
    chmod +x phpunit.phar && \
    mv phpunit.phar /usr/bin/phpunit

RUN yum -y install gcc cmake
RUN pecl install swoole
RUN easy_install supervisor
RUN yum -y --enablerepo=remi install php-pecl-imagick php-intl
RUN yum -y install ncurses-devel
RUN wget http://jonas.nitro.dk/tig/releases/tig-2.1.1.tar.gz && \
    tar -zxvf tig-2.1.1.tar.gz && \
    cd tig-2.1.1 && \
    ./configure && make && make install

#add ssh account
RUN /etc/init.d/sshd start
RUN echo 'root:root' | chpasswd
## Set up SSHD config
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

#add mysql account and init db
RUN /etc/init.d/mysqld start && \
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by '';" && \
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by '';"
#    mysql -e "grant all privileges on *.* to 'hellofarm'@'%' identified by 'halfquestfarm4321';" && \
#    mysql -e "grant all privileges on *.* to 'hellofarm'@'localhost' identified by 'halfquestfarm4321';"

#deal conf
RUN sed -i -e 's/^user = apache/user = root/g' \
           -e 's/^group = apache/group = root/g' /etc/php-fpm.d/www.conf
#RUN sed -i -e 's/^upload_max_filesize = 2M/upload_max_filesize = 300M/g' \
#           -e 's/^max_file_uploads = 20/max_file_uploads = 2048/g' /etc/php.ini
RUN sed -i '$a\extension=swoole.so' /etc/php.ini
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY supervisord.conf /etc/supervisord.conf
COPY init.sh /root/init.sh

EXPOSE 22 80
CMD ["/root/init.sh"]
