FROM alpine:latest

ARG GLIBC_VERSION='2.30-r0'
ENV GID 33
ENV UID 33

RUN apk --no-cache add shadow libstdc++ \
    && wget -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
    && apk --no-cache add glibc-${GLIBC_VERSION}.apk \
    && apk --no-cache add glibc-bin-${GLIBC_VERSION}.apk \
    && mkdir /rrys \
    && wget -O /rrys/rrys.tar.gz http://appdown.rrys.tv/rrshareweb_centos7.tar.gz \
    && tar xzvf /rrys/rrys.tar.gz -C /rrys/ \
    && rm /rrys/rrys.tar.gz \
    && rm -rf /glibc-${GLIBC_VERSION}.apk \
    && rm -rf /glibc-bin-${GLIBC_VERSION}.apk \
    && mkdir /rrys/downloads \
    && sed -i 's#/opt/work/store#/rrys/downloads#' /rrys/rrshareweb/conf/rrshare.db

COPY aux-files/entry.sh /entry.sh
RUN chmod +x /entry.sh

VOLUME /rrys/downloads

EXPOSE 3001

ENTRYPOINT ["/entry.sh"]
