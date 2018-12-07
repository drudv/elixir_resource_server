defmodule MongoConnection do
  use GenServer

  def init(_) do
    {:ok, %{}}
  end

  def start_link() do
    Mongo.start_link(url: "mongodb://localhost:27017/db-name")
    GenServer.start_link(__MODULE__, [])
  end
end
