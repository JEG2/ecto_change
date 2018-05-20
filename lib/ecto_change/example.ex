defmodule EctoChange.Example do
  import Ecto.Query, only: [from: 2]
  alias EctoChange.{SomeModel, Repo}

  def run do
    load_database()
    show_change()
  end

  defp load_database do
    unless Repo.get_by(SomeModel, some_field: 42) do
      %SomeModel{some_field: 42} |> Repo.insert!
    end
  end

  defp show_change do
    [%{some_field: 42}] =
      from(
        s in SomeModel,
        select: %{ },
        select_merge: map(s, [:some_field])
      )
      |> Repo.all
    IO.puts "The query worked as expected."
  end
end
