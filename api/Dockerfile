FROM ruby:2.3
MAINTAINER hey@vito.io

RUN apt-get update
RUN apt-get -y install build-essential locales \
    autoconf zlib1g-dev libssl-dev \
    libreadline-dev libyaml-dev \
    libcurl4-openssl-dev curl git-core \
    python-software-properties libxml2-dev \
    libxslt1-dev imagemagick graphicsmagick-libmagick-dev-compat

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc

RUN mkdir -p /var/www/app
WORKDIR /var/www/app

COPY Gemfile Gemfile.lock ./
RUN gem update --system
RUN gem install bundler && bundle install --jobs 20 --retry 5

EXPOSE 3000

COPY . ./

