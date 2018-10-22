FROM alpine:3.8

RUN apk --no-cache add tini lighttpd lighttpd-mod_auth \
    && echo 'include_shell "cat /etc/lighttpd/conf.d/*conf 2> /dev/null"' >> /etc/lighttpd/lighttpd.conf \
    && mkdir -p /etc/lighttpd/conf.d \
    && mkdir -p /var/log/lighttpd \
    && mkdir -p /var/www/html \
    && chown lighttpd /run \
    && ln -sf /dev/stderr /var/log/lighttpd/access.log \
    && ln -sf /dev/stderr /var/log/lighttpd/error.log \
    && sed -i 's/\(^server.document-root.*$\)/#\1/g' /etc/lighttpd/lighttpd.conf

COPY ./conf/000-base.conf /etc/lighttpd/conf.d/
COPY ./www/index.html /var/www/html/index.html

USER lighttpd

EXPOSE 8000

ENTRYPOINT ["tini", "--"]
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

