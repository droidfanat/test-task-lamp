FROM ubuntu:18.04

ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN apt-get update && \
    apt-get install -y apache2 php php-curl php-cli php-mysql 

ADD "http://www.adminer.org/latest.php"  /usr/share/adminer/latest.php 
RUN ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php && \
    echo "Alias /adminer.php /usr/share/adminer/adminer.php" |  tee /etc/apache2/conf-available/adminer.conf && \
    a2enconf adminer.conf && \
    chown -R www-data:www-data /usr/share/adminer



EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
