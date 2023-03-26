defmodule WexhookWeb.HomeLive.ParserTest do
  use ExUnit.Case, async: true

  alias WexhookWeb.HomeLive.Parser

  describe "parse_response_http_code/1" do
    test "returns 200 when empty string is given" do
      assert Parser.parse_response_http_code("") == 200
    end

    test "returns 200 when 200 is given" do
      assert Parser.parse_response_http_code("200") == 200
    end

    test "returns 404 when 404 is given" do
      assert Parser.parse_response_http_code("404") == 404
    end
  end

  describe "parse_response_body/1" do
    test "returns empty json when empty string is given" do
      assert Parser.parse_response_body("") == ~s({"status":"ok"})
    end

    test "returns given json when json is given" do
      assert Parser.parse_response_body(~s({"hello":"ok"})) == ~s({"hello":"ok"})
    end
  end
end
