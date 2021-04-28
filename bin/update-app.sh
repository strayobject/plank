#!/usr/bin/env bash

docker-compose exec app bash -c "mix deps.get && mix ecto.create && mix ecto.migrate && cd assets && npm install"