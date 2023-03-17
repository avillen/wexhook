defmodule Wexhook.Support.Strings do
  def random_string do
    Base.encode32(:crypto.strong_rand_bytes(10))
  end
end
