FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

# Install prerequisites
RUN apt update && apt -y install wget make xz-utils && \
    apt-get clean && rm -rf /var/lib/apt/*

# Install aaPanel; cleanup; create persistence skeleton and remove /www
RUN wget -O /var/tmp/install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && \
    printf "y\nyes\n" | (cd /var/tmp && bash ./install.sh) && \
    apt-get clean && rm -rf /var/lib/apt/* && \
    rm -rf /root/.cache /var/tmp/install.sh && \
    printf "aapanel\n" | bt 6 && \
    printf "aapanel123\n" | bt 5 && \
    bt 2 && \
    echo "/aapanel" >/www/server/panel/data/admin_path.pl && \
    tar cvJf /www-skel.tar.xz /www && \
    rm -rf /www

RUN tar cvJf /etc-skel.tar.xz /etc

RUN apt update && apt -y install \
	python3 python3-pip \
	cmake gawk \
	libxslt1-dev libxslt1.1 \
	libgdm1 libgdm-dev && \
    apt-get clean && rm -rf /var/lib/apt/*

COPY docker-entrypoint.sh /

# Volumes for persistent data
VOLUME /www/backup
VOLUME /www/server
VOLUME /www/wwwlogs
VOLUME /www/wwwroot
VOLUME /etc

# Ports
EXPOSE 7800
EXPOSE 888
EXPOSE 80
EXPOSE 443
EXPOSE 20
EXPOSE 21

# Entrypoint
ENTRYPOINT [ "/docker-entrypoint.sh" ]
