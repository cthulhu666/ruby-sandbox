FROM cthulhu666/docker-rbenv

RUN gem install rspec
WORKDIR /app/spec
CMD timeout --kill-after=1 2 rspec .

