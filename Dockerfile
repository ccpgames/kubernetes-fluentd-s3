FROM fluent/fluentd:latest-onbuild
MAINTAINER Högni Gylfason <klumhru@gmail.com>
WORKDIR /home/fluent
COPY /entrypoint.sh /home/fluent/entrypoint.sh
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

# We need root access to read container logs
USER root
RUN apk --no-cache --update add build-base ruby-dev && \
    gem install fluent-plugin-s3 && \
    rm -rf /root/.gem/ruby/2.3.0/cache/*.gem && gem sources -c && \
    apk del build-base ruby-dev && rm -rf /var/cache/apk/*

ENTRYPOINT ["sh", "entrypoint.sh"]
