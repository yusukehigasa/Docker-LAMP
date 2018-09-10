FROM centos:6

#LABEL  maintainer "y.higasa <higasa@studio-higasa.com>"

RUN yum -y update && \
    yum clean all

# apache の導入
RUN yum -y install httpd && \
    yum clean all

# git の導入
RUN yum -y install git && \
    yum clean all

# epel repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm

# remi repo
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN sed -i '4a priority=1' /etc/yum.repos.d/remi-php72.repo

# phpパッケージを導入
RUN yum -y install --enablerepo=remi-php72 php php-common php-devel php-intl php-mysql php-mbstring php-pdo php-gd php-xml php-mcrypt php-tokenizer php-pear && \
    yum clean all

# ライブラリを導入
RUN yum -y install openssl-devel zip unzip && \
    yum clean all

# composer の導入
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

# 作業用ディレクトリの設定
WORKDIR /var/www/html
