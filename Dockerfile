FROM ruby:2.2.3-slim

RUN apt-get update \
  && apt-get install -y git-core build-essential \
  && apt-get clean

ADD Gemfile /app/
ADD Gemfile.lock /app/
ADD vendor/cache /app/vendor/cache
WORKDIR /app
RUN bundle install --local

VOLUME ["/app"]
CMD ["rails", "s"]

