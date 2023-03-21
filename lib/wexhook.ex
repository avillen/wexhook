defmodule Wexhook do
  @moduledoc """
  Wexhook business logic.
  """

  alias __MODULE__.{
    Request,
    ServerRepo,
    ServersSupervisor
  }

  alias Wexhook.Support.Strings

  @type id :: String.t()
  @type request :: Request.t()

  @spec new_server(id) :: {:ok, pid}
  def new_server(id \\ Strings.random_string()) do
    ServersSupervisor.start_server(id)
  end

  @spec add_request(pid, request) :: :ok
  def add_request(pid, request) do
    ServerRepo.push_request(pid, request)
    Phoenix.PubSub.broadcast(Wexhook.PubSub, topic(pid), {:request, request})
  end

  @spec get_requests(pid) :: [request]
  def get_requests(pid) do
    ServerRepo.get_requests(pid)
  end

  @spec get_request(pid, Request.id()) :: request | nil
  def get_request(pid, id) do
    ServerRepo.get_request(pid, id)
  end

  @spec delete_request(pid, Request.id()) :: [request]
  def delete_request(pid, id) do
    ServerRepo.delete_request(pid, id)
  end

  @spec delete_requests(pid) :: [request]
  def delete_requests(pid) do
    ServerRepo.delete_requests(pid)
  end

  @spec get_request_count(pid) :: non_neg_integer()
  def get_request_count(pid) do
    ServerRepo.get_request_count(pid)
  end

  @spec get_server_count() :: non_neg_integer()
  def get_server_count do
    ServersSupervisor.get_server_count()
  end

  @spec delete_server(pid) :: :ok
  def delete_server(pid) do
    ServersSupervisor.delete_server(pid)
  end

  @spec delete_servers() :: :ok
  def delete_servers do
    ServersSupervisor.delete_servers()
  end

  @spec get_server_id(pid) :: id
  def get_server_id(pid) do
    ServerRepo.get_id(pid)
  end

  @spec get_server_by_id(id) :: pid | nil
  def get_server_by_id(id) do
    ServersSupervisor.get_server_pid_by_id(id)
  end

  @spec subscribe_to_server(pid) :: :ok
  def subscribe_to_server(pid) do
    Phoenix.PubSub.subscribe(Wexhook.PubSub, topic(pid))
  end

  defp topic(pid) do
    get_server_id(pid)
  end
end
