# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fanivia <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/26 14:46:05 by fanivia           #+#    #+#              #
#    Updated: 2020/10/29 19:14:18 by fanivia          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM    alpine:3.12.2
RUN     apk update && apk upgrade
RUN     apk add openssl openssh
RUN     apk add nginx
RUN     apk add supervisor
COPY    ./srcs/nginx.conf /etc/nginx/conf.d/default.conf

# создаем юзера-абьюезера
RUN     adduser -D -g 'xxx' xxx
RUN     mkdir /xxx
RUN     chown -R xxx:xxx /var/lib/nginx
RUN     chown -R xxx:xxx /xxx
RUN     mkdir -p /run/nginx

RUN     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.crt \
        -out /etc/ssl/private/nginx-selfsigned.key \
        -subj "/C=RF/ST=Moscow/L=Moscow/O=school21/OU=fanivia/CN=my_domain"

COPY    ./srcs/supervisord.conf /etc/

RUN     wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.0_linux_amd64.tar.gz
RUN     tar -xf telegraf-1.17.0_linux_amd64.tar.gz --strip-components=2 -C
RUN     rm telegraf-1.17.0_linux_amd64.tar.gz
COPY    telegraf.conf /etc/telegraf/

COPY    ./srcs/index.html /www/index.html

EXPOSE  80 443

CMD     ["supervisord", "-c", "/etc/supervisord.conf"]