defmodule WexhookWeb.HookController.SerializerTest do
  use ExUnit.Case, async: true

  describe "parse_body/1" do
    test "returns a map when the body is a valid JSON" do
      assert %{"foo" => "bar"} =
               WexhookWeb.HookController.Serializer.parse_body(~s({"foo": "bar"}))
    end

    test "returns the body when the body is not a valid JSON" do
      assert "foo" = WexhookWeb.HookController.Serializer.parse_body("foo")
    end
  end
end
