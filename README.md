# A Change in Ecto

## Short Story

The following query works as expected in Ecto 2.2, 
but dies with a strange error in `master`:

```elixir
[%{some_field: 42}] =
  from(
    s in SomeModel,
    select: %{ },
    select_merge: map(s, [:some_field])
  )
  |> Repo.all
```

## See the Change

Adjust `config/config.exs` to point at your local copy of PostgreSQL,
then run through the following steps to see the code work on Ecto 2.2:

```
mix deps.get
mix ecto.create
mix ecto.migrate
mix run -e 'EctoChange.Example.run'
```

You should see this line of output:

```
The query worked as expected.
```

Now reverse the commenting of these two lines in `mix.exs`:

```
{:ecto, "~> 2.2"}  # comment out
# {:ecto, github: "elixir-ecto/ecto"}  # comment in
```

They should now look like this:

```
# {:ecto, "~> 2.2"}  # comment out
{:ecto, github: "elixir-ecto/ecto"}  # comment in
```

Finally, run the following commands to see the error from `master`:

```
mix deps.get
mix run -e 'EctoChange.Example.run'
```

The error looks like this:

```
** (Ecto.QueryError) cannot select_merge source at position 0 into %{}, those select expressions are incompatible in query:                                

from s in EctoChange.SomeModel,
  select: %{}

    (ecto) lib/ecto/query/builder/select.ex:260: Ecto.Query.Builder.Select.merge/6                                                                         
    (ecto_change) lib/ecto_change/example.ex:18: EctoChange.Example.show_change/0                                                                          
    (stdlib) erl_eval.erl:670: :erl_eval.do_apply/6
    (elixir) lib/code.ex:192: Code.eval_string/3
    (elixir) lib/enum.ex:737: Enum."-each/2-lists^foreach/1-0-"/2
    (elixir) lib/enum.ex:737: Enum.each/2
    (mix) lib/mix/tasks/run.ex:132: Mix.Tasks.Run.run/5
```
