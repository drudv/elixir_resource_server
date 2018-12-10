defmodule GiveMe5Handler do
  def init(_type, _req, _opts \\ []) do
    {:upgrade, :protocol, :cowboy_rest}
  end

  def content_types_provided(req, state) do
    {[
       {"application/json", :to_json}
     ], req, state}
  end

  def to_json(req, state) do
    found =
      Mongo.find(:mongo, "message", %{},
        limit: 5,
        sort: %{created: -1},
        pool: DBConnection.Poolboy
      )
      |> Enum.to_list()
      |> Enum.map(&Map.delete(&1, "_id"))

    {:ok, encoded} = Poison.encode(found, %{})
    {encoded, req, state}
  end
end
