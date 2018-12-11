defmodule UUIDHandler do
  def init(_type, _req, _opts \\ []) do
    {:upgrade, :protocol, :cowboy_rest}
  end

  def content_types_provided(req, state) do
    {[
       {"text/plain", :to_text}
     ], req, state}
  end

  def to_text(req, state) do
    uuid = UUID.uuid4()
    {uuid, req, state}
  end
end
