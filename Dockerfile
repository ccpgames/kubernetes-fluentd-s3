FROM fluent/fluentd:latest-onbuild
MAINTAINER Högni Gylfason <klumhru@gmail.com>
WORKDIR /home/fluent
COPY /entrypoint.sh /home/fluent/entrypoint.sh
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root
RUN apk --no-cache --update add sudo build-base ruby-dev && \

    sudo -u fluent gem install fluent-plugin-s3 && \

    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && sudo -u fluent gem sources -c && \
    apk del sudo build-base ruby-dev && rm -rf /var/cache/apk/*

USER fluent

ENTRYPOINT ["sh", "entrypoint.sh"]
