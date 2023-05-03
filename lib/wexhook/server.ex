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
  @type harakiri_timeout :: non_neg_integer()

  @type t :: %__MODULE__{
          id: id,
          requests: [request],
          response: response,
          harakiri_timeout: harakiri_timeout
        }

  defstruct ~w(
    id
    requests
    response
    harakiri_timeout
  )a

  @spec new(id, harakiri_timeout) :: t
  def new(id, harakiri_timeout) do
    %__MODULE__{
      requests: [],
      id: id,
      response: Response.new(),
      harakiri_timeout: harakiri_timeout
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

  @spec get_hari_timeout(t) :: harakiri_timeout
  def get_hari_timeout(server) do
    server.harakiri_timeout
  end
end
