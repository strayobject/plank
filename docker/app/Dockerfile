FROM elixir:1.11

RUN apt-get -y update \
  && apt-get -y install inotify-tools nodejs npm --no-install-recommends \
  && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

RUN mix local.hex --force && mix local.rebar --force

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

EXPOSE 4000
CMD ["mix", "phx.server"]