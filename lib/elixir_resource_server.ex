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
           {"/save-me", SaveMeHandler, []}
         ]}
      ])

    {:ok, _} =
      :cowboy.start_http(
        :http,
        100,
        [{:port, 8080}],
        [{:env, [{:dispatch, dispatch}]}]
      )

    children = [
      worker(Mongo, [
        [name: :mongo, url: "mongodb://localhost:27017/test", pool: DBConnection.Poolboy]
      ])
    ]

    opts = [strategy: :one_for_one, name: ElixirResourceServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
