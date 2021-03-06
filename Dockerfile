FROM centos:6

#LABEL  maintainer "USERNAME <USEREMAIL>"

RUN yum -y update && \
    yum clean all

# For install Apache
RUN yum -y install httpd && \
    yum clean all

# For install Git
RUN yum -y install git && \
    yum clean all

# For add EPEL repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm

# For add REMI repo
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN sed -i '4a priority=1' /etc/yum.repos.d/remi-php72.repo

# For install PHP Packages
RUN yum -y install --enablerepo=remi-php72 php php-common php-devel php-intl php-mysql php-mbstring php-pdo php-gd php-xml php-mcrypt php-tokenizer php-pear php-pecl-zip && \
    yum clean all

# For install Libraries
RUN yum -y install libcurl-devel libpng-devel openssl-devel zip unzip wget && \
    yum clean all

# For install wkhtmltox
RUN yum -y install fontconfig libXrender libXext xorg-x11-fonts-Type1 xorg-x11-fonts-75dpi freetype libpng zlib libjpeg-turbo && \
    yum clean all

RUN wget https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox-0.12.5-1.centos6.x86_64.rpm
RUN rpm -Uvh wkhtmltox-0.12.5-1.centos6.x86_64.rpm

# For add font in japanese
RUN wget http://dl.ipafont.ipa.go.jp/IPAexfont/IPAexfont00301.zip
RUN unzip IPAexfont00301.zip
RUN mv IPAexfont00301 /usr/share/fonts

# For install Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

# For set work dir
WORKDIR /var/www/html
