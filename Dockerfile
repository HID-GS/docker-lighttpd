FROM alpine:3.8

RUN apk --no-cache add tini lighttpd vim bash \
    && echo 'include_shell "cat /etc/lighttpd/conf.d/*conf 2> /dev/null"' >> /etc/lighttpd/lighttpd.conf \
    && mkdir -p /etc/lighttpd/conf.d \
    && mkdir -p /var/log/lighttpd \
    && chown lighttpd /run \
    && ln -sf /dev/stdout /var/log/lighttpd/access.log \
    && ln -sf /dev/stderr /var/log/lighttpd/error.log

COPY ./conf/000-base.conf /etc/lighttpd/conf.d/

USER lighttpd

ENTRYPOINT ["tini", "--"]
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

