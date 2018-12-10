defmodule SaveMeHandler do
  def init(_type, _req, _opts \\ []) do
    {:upgrade, :protocol, :cowboy_rest}
  end

  def allowed_methods(conn, state) do
    {["POST"], conn, state}
  end

  def content_types_accepted(conn, state) do
    {[{"application/json", :from_json}], conn, state}
  end

  def content_types_provided(conn, state) do
    {[{"application/json", :to_json}], conn, state}
  end

  def store_message(message, uuid) do
    created = DateTime.utc_now() |> DateTime.to_iso8601()
    data = %{message: message, uuid: uuid, created: created}

    {:ok, %Mongo.InsertOneResult{inserted_id: _}} =
      Mongo.insert_one(:mongo, "message", data, pool: DBConnection.Poolboy)

    data
  end

  def from_json(req, state) do
    {:ok, body, req2} = :cowboy_req.body(req)
    data = Poison.decode!(body)

    saved_data =
      case data do
        %{"message" => message, "uuid" => uuid} ->
          store_message(message, uuid)

        %{"message" => message} ->
          store_message(message, UUID.uuid4())

        _ ->
          raise "Wrong format"
      end

    {:ok, encoded} = Poison.encode(saved_data, %{})
    req3 = :cowboy_req.set_resp_body(encoded, req2)
    {true, req3, state}
  end
end
