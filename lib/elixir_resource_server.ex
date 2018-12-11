defmodule ElixirResourceServer do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    dispatch =
      :cowboy_router.compile([
        {:_,
         [
           {"/", ToppageHandler, []},
           {"/give-me-five", GiveMe5Handler, []},
           {"/save-me", SaveMeHandler, []},
           {"/uuid", UUIDHandler, []}
         ]}
      ])

    {:ok, _} =
      :cowboy.start_http(
        :http,
        100,
        [{:port, 8080}],
        [{:env, [{:dispatch, dispatch}]}]
      )

    mongo_url = System.get_env("MONGO_URL")

    unless mongo_url do
      raise "MONGO_URL environment variable is not set"
    end

    IO.inspect(mongo_url)

    children = [
      worker(Mongo, [
        [name: :mongo, url: mongo_url, pool: DBConnection.Poolboy]
      ])
    ]

    opts = [strategy: :one_for_one, name: ElixirResourceServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
