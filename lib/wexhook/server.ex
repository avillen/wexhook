defmodule Wexhook.Server do
  @moduledoc """
  Server entity.
  """

  alias Wexhook.{
    Request,
    Response
  }

  @type id :: String.t()
  @type request :: Request.t()
  @type response :: Response.t()

  @type t :: %__MODULE__{
          id: id,
          requests: [request],
          response: response
        }

  defstruct ~w(
    id
    requests
    response
  )a

  @spec new(id) :: t
  def new(id) do
    %__MODULE__{
      requests: [],
      id: id,
      response: Response.new()
    }
  end

  @spec add_request(t, request) :: t
  def add_request(server, request) do
    %__MODULE__{
      server
      | requests: [request | server.requests]
    }
  end

  @spec get_requests(t) :: [request]
  def get_requests(server) do
    server.requests
  end

  @spec get_request(t, Request.id()) :: Request.t()
  def get_request(server, id) do
    Enum.find(server.requests, fn request -> request.id == id end)
  end

  @spec delete_request(t, Request.id()) :: t
  def delete_request(server, id) do
    %__MODULE__{
      server
      | requests: Enum.reject(server.requests, fn request -> request.id == id end)
    }
  end

  @spec delete_requests(t) :: t
  def delete_requests(server) do
    %__MODULE__{
      server
      | requests: []
    }
  end

  @spec get_request_count(t) :: non_neg_integer()
  def get_request_count(server) do
    Enum.count(server.requests)
  end

  @spec get_id(t) :: id
  def get_id(server) do
    server.id
  end

  @spec set_response(t, response) :: t
  def set_response(server, response) do
    %__MODULE__{
      server
      | response: response
    }
  end

  @spec get_response(t) :: response
  def get_response(server) do
    server.response
  end
end
