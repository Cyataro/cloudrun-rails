FROM ruby:2.7.2
ENV BUNDLER_VERSION 2.1.4
ENV LANG C.UTF-8
ENV APP_ROOT /app

# install packages
RUN curl https://deb.nodesource.com/setup_12.x | bash && \
    curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    apt-get update -qq && \
    apt-get install -y build-essential \
            libpq-dev \
            postgresql-client \
            nodejs \
            curl \
            apt-transport-https \
            wget

RUN npm install --global yarn
RUN gem install bundler:$BUNDLER_VERSION

# setup work dir
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

ADD . $APP_ROOT

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bin/entrypoint"]
