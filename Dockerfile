FROM ruby:2.5-alpine

RUN apk update && apk add --no-cache \
  build-base \
  nodejs \
  postgresql-dev \
  git \
  tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install --without test --binstubs --jobs 3

COPY . .

LABEL maintainer="Turing Engineering <contact@turing.edu>"

CMD rm -f tmp/pids/server.pid && bin/rails server puma -p $PORT -b 0.0.0.0
