FROM ruby:3.4.7

RUN groupadd --system ruby && \
    useradd --system --create-home --gid ruby ruby && \
    mkdir -p /usr/src/app && \
    chown ruby:ruby /usr/src/app && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      dumb-init \
      libjemalloc2 \
      && \
    rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

WORKDIR /usr/src/app

EXPOSE 8000
ENV PORT 8000
ENV APP_DIR /usr/src/app

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
ENV MALLOC_CONF=dirty_decay_ms:1000,narenas:2,background_thread:true

ENV RUBY_YJIT_ENABLE=1

USER ruby
COPY --chown=ruby:ruby Gemfile* /usr/src/app/
RUN bundle install --deployment
COPY --chown=ruby:ruby . /usr/src/app

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "/usr/src/app/web_start.sh" ]
