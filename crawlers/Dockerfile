FROM ruby:2.3
MAINTAINER hey@vito.io

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV BUNDLE_GEMFILE=/app/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    locales \
    autoconf \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libcurl4-openssl-dev \
    curl \
    git-core \
    python-software-properties \
    libxml2-dev \
    libxslt1-dev \
    imagemagick \
    graphicsmagick-libmagick-dev-compat \
&& rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc

RUN mkdir -p /app
WORKDIR /app
ADD Gemfile* ./

RUN bundle install --jobs 20 --retry 5

COPY . ./
