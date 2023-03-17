defmodule Wexhook.Server.State do
  alias Wexhook.Request

  @type public_path :: String.t()
  @type requests :: [Request.t()]

  @type t :: %__MODULE__{
          public_path: public_path,
          requests: requests
        }

  defstruct ~w(
    public_path
    requests
  )a

  @spec new(public_path) :: t
  def new(public_path) do
    %__MODULE__{
      requests: [],
      public_path: public_path
    }
  end

  @spec add_request(t, any()) :: t
  def add_request(state, request) do
    %__MODULE__{
      state
      | requests: [request | state.requests]
    }
  end

  @spec get_requests(t) :: requests
  def get_requests(state) do
    state.requests
  end

  @spec get_request(t, Request.id()) :: Request.t()
  def get_request(state, id) do
    Enum.find(state.requests, fn request -> request.id == id end)
  end

  @spec delete_request(t, Request.id()) :: t
  def delete_request(state, id) do
    %__MODULE__{
      state
      | requests: Enum.reject(state.requests, fn request -> request.id == id end)
    }
  end

  @spec delete_requests(t) :: t
  def delete_requests(state) do
    %__MODULE__{
      state
      | requests: []
    }
  end

  @spec get_request_count(t) :: non_neg_integer()
  def get_request_count(state) do
    Enum.count(state.requests)
  end

  @spec get_public_path(t) :: public_path
  def get_public_path(state) do
    state.public_path
  end
end
