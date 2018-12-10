defmodule ToppageHandler do
  def init(_type, _req, _opts \\ []) do
    {:upgrade, :protocol, :cowboy_rest}
  end

  def content_types_provided(req, state) do
    {[
       {"text/html", :to_html}
     ], req, state}
  end

  def to_html(req, state) do
    body = "<html>
      <head>
        <meta charset=\"utf-8\">
        <title>Resource Provider in Elixir</title>
      </head>
      <body>
        <p>Resource Provider in Elixir</p>
      </body>
      </html>"
    {body, req, state}
  end
end
