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
    IO.inspect("content_types_provided")
    {[{"application/json", :to_json}], conn, state}
  end

  def from_json(req, state) do
    IO.inspect("from_json")
    req = :cowboy_req.set_resp_body("Hello", req)
    {true, req, state}
  end
end
