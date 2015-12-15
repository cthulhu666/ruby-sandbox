FROM cthulhu666/docker-rbenv

RUN gem install rspec rspec-rails
WORKDIR /app/spec
CMD timeout --kill-after=1 2 rspec .
