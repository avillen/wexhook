defmodule Wexhook.Support.Strings do
  @moduledoc """
  A module for string manipulation.
  """

  def random_string(n \\ 10) do
    Base.encode32(:crypto.strong_rand_bytes(n))
  end
end
