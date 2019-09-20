FROM ruby:2.6.3-alpine
LABEL maintainer="bcrivelaro"

RUN apk --update add build-base nodejs yarn postgresql-client postgresql-dev \
    tzdata bash less && rm -rf /var/cache/apk/

ENV APP_HOME /happy_nel
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# package.json yarn.lock
COPY Gemfile Gemfile.lock $APP_HOME/

RUN bundle install -j 4 --retry 5
RUN yarn install

COPY . $APP_HOME

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]