defmodule WexhookWeb.HomeLive.Parser do
  def parse_response_http_code(""), do: 200
  def parse_response_http_code(http_code), do: String.to_integer(http_code)

  def parse_response_body(""), do: ~s({"status":"ok"})
  def parse_response_body(body), do: body
end
