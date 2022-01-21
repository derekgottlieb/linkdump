FROM ruby:3.1.0

RUN groupadd --system ruby && \
    useradd --system --create-home --gid ruby ruby && \
    mkdir -p /usr/src/app && \
    chown ruby:ruby /usr/src/app && \
    apt-get update && \
    apt-get install -y dumb-init && \
    rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

WORKDIR /usr/src/app

EXPOSE 8000
ENV PORT 8000
ENV APP_DIR /usr/src/app

USER ruby
COPY --chown=ruby:ruby Gemfile* /usr/src/app/
RUN bundle install --deployment
COPY --chown=ruby:ruby . /usr/src/app

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "/usr/src/app/web_start.sh" ]
