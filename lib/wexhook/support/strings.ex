defmodule Wexhook.Support.Strings do
  @moduledoc """
  A module for string manipulation.
  """

  def random_string do
    Base.encode32(:crypto.strong_rand_bytes(10))
  end
end
