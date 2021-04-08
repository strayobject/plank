# Plank

A board. Like Trello, but worse. Use at your own peril.

## Licence

Plank is licenced under [GPLv3](https://github.com/strayobject/plank/blob/main/LICENSE)

## Environment

### Secrets

Run `cp ./docker/app/.env.dist ./docker/app/.env && cp ./docker/postgres/.env.dist ./docker/postgres/.env`

And populate them with valid secrets. Make sure that postgres secrets match DB_ section in the app's `.env`

Use `mix` to generate secret values for ./docker/app/.env

`SECRET_KEY_BASE` - `docker-compose exec app bash -c "cd /app && mix phx.gen.secret"`

`LIVE_VIEW_SALT` - `docker-compose exec app bash -c "cd /app && mix phx.gen.secret 32"`

### Run

Whilst it can be run locally. Development is easier
when using Docker.

Use `./bin/start.sh` to start the environment.
Use `./bin/restart-app.sh` to restart the app container.


## Notes

As the project is in early stages, some manual steps
are still required.

Basic seeds are available should you wish 
to use them and migrations may need to be
run. Use `mix` for both.


## Standard Phoenix setup

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
