defmodule Wexhook.Server.InMemory.State do
  alias Wexhook.Request

  @type id :: String.t()
  @type requests :: [Request.t()]

  @type t :: %__MODULE__{
          id: id,
          requests: requests
        }

  defstruct ~w(
    id
    requests
  )a

  @spec new(id) :: t
  def new(id) do
    %__MODULE__{
      requests: [],
      id: id
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

  @spec get_id(t) :: id
  def get_id(state) do
    state.id
  end
end
