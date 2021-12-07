FROM elixir:1.12
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get install -y postgresql-client inotify-tools
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new 1.6.0 --force
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get install -y -q nodejs
RUN apt-get install -y -q inotify-tools
# Install hex & rebar
RUN mix local.hex --force && \
  mix local.rebar --force && \
  mix hex.info
RUN mkdir -p /blog
COPY . /blog
WORKDIR /blog
ENV MIX_ENV dev
EXPOSE 4000
EXPOSE 4002
CMD ["mix", "phx.server"]
