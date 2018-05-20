defmodule EctoChange.Repo.Migrations.PrepareDatabase do
  use Ecto.Migration

  def change do
    create table(:some_models) do
      add :some_field, :integer
    end
  end
end
