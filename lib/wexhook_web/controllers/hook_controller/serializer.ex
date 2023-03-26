defmodule WexhookWeb.HookController.Serializer do
  def parse_body(body) do
    case Jason.decode(body) do
      {:ok, json} -> json
      {:error, _} -> body
    end
  end
end
