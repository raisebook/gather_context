FROM elixir:1.6.6
RUN apt-get update && apt-get install -y apt-transport-https inotify-tools
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get install -y nodejs yarn

RUN apt-get -y upgrade

RUN mix local.hex --force && \
  mix local.rebar --force

WORKDIR /app

CMD ["/usr/local/bin/mix"]
