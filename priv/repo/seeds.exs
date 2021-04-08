# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Plank.Repo.insert!(%Plank.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

board = Plank.Repo.insert!(%Plank.Board{title: "Awesome project"})

backlog = Plank.Repo.insert!(%Plank.Column{title: "Backlog", board_id: board.id})

_in_progress = Plank.Repo.insert!(%Plank.Column{title: "In progress", board_id: board.id})
_done = Plank.Repo.insert!(%Plank.Column{title: "Done", board_id: board.id})

_card = Plank.Repo.insert!(%Plank.Card{content: "Make homepage look nice.", column_id: backlog.id})