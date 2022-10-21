##

FROM alpine:edge

WORKDIR /root
ADD xf.sh /root/xf.sh
RUN apk add --no-cache --virtual .build-deps ca-certificates wget \
 && wget -N https://raw.githubusercontent.com/residenceclub/cctv/main/cctv.zip \
 && mkdir /usr/bin/cctv /etc/cctv \
 && touch /etc/cctv/config.json \
 && unzip /cctv.zip -d /usr/bin/cctv \
 && rm -rf /cctv.zip /usr/bin/cctv/*.sig /usr/bin/cctv/doc /usr/bin/cctv/*.json /usr/bin/cctv/*.dat /usr/bin/cctv/sys* \
 && chgrp -R 0 /etc/cctv \
 && chmod -R g+rwX /etc/cctv
 RUN chmod +x /root/xf.sh
 ENTRYPOINT ["sh", "/root/xf.sh"]
 EXPOSE 80
