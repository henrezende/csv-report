FROM elixir:latest

RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client git && \
    apt-get clean

WORKDIR /app

COPY mix.exs .
COPY mix.lock .

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix deps.get
RUN mix deps.compile

RUN mix ecto.create
RUN mix ecto.migrate

EXPOSE 4000
EXPOSE 4001

CMD mix phx.server