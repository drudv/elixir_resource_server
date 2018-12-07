defmodule GiveMe5Handler do
  def init(_type, _req, _opts \\ []) do
    {:upgrade, :protocol, :cowboy_rest}
  end

  def content_types_provided(req, state) do
    {[
       {"application/json", :hello_to_json}
     ], req, state}
  end

  def hello_to_json(req, state) do
    body = "{\"rest\": \"Five!\"}"
    {body, req, state}
  end
end
