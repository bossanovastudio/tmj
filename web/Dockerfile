FROM ruby:2.3
MAINTAINER hey@vito.io

RUN apt-get update && apt-get install -y \
    build-essential \
    locales \
    nodejs

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir -p /var/www/app
WORKDIR /var/www/app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

EXPOSE 3000

COPY . ./
