FROM ubuntu:16.04
MAINTAINER Simon Lacroix <simon@test.io>

RUN apt-get update && apt-get install -y \
  autoconf \
  build-essential \
  curl \
  g++ \
  git \
  libmysql++-dev \
  libreadline-dev \
  libssl-dev \
  nano \
  vim \
  wget

# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# Install Ruby
ENV RUBY_VERSION 2.4.2
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install $RUBY_VERSION
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN rbenv global $RUBY_VERSION
RUN gem update --system
RUN gem install bundler --force

# Create the app directory
RUN mkdir /app
WORKDIR /app

# Expose port
EXPOSE 3000

# Default command
CMD bundle exec rails s -b 0.0.0.0

# ============ #
# App specific #
# ============ #

# Install gems
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

# Copy the app
ADD . /app
