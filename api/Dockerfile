FROM ruby:2.3
MAINTAINER jotadev@me.com


RUN apt-get update && apt-get -y install \
    autoconf \
    build-essential \
    curl \
    Ghostscript \
    git-core \
    graphicsmagick-libmagick-dev-compat \
    imagemagick \
    libcurl4-openssl-dev \
    libmagickwand-dev \
    libreadline-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    locales \
    python-software-properties \
    zlib1g-dev

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile* /app/
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0", "-P", "/dev/null"]
