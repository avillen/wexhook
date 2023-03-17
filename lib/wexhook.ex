defmodule Wexhook do
  alias __MODULE__.{
    Request,
    Server,
    ServersSupervisor
  }

  @type public_path :: String.t()
  @type request :: Request.t()

  @spec new_server(public_path) :: {:ok, pid}
  def new_server(public_path \\ random_public_path()) do
    ServersSupervisor.start_server(public_path)
  end

  @spec add_request(pid, request) :: :ok
  def add_request(pid, request) do
    Server.push_request(pid, request)
  end

  @spec get_requests(pid) :: [request]
  def get_requests(pid) do
    Server.get_requests(pid)
  end

  @spec get_request(pid, Request.id()) :: request | nil
  def get_request(pid, id) do
    Server.get_request(pid, id)
  end

  @spec delete_request(pid, Request.id()) :: [request]
  def delete_request(pid, id) do
    Server.delete_request(pid, id)
  end

  @spec delete_requests(pid) :: [request]
  def delete_requests(pid) do
    Server.delete_requests(pid)
  end

  @spec get_request_count(pid) :: non_neg_integer()
  def get_request_count(pid) do
    Server.get_request_count(pid)
  end

  @spec get_server_count() :: non_neg_integer()
  def get_server_count() do
    ServersSupervisor.get_server_count()
  end

  @spec delete_server(pid) :: :ok
  def delete_server(pid) do
    ServersSupervisor.delete_server(pid)
  end

  @spec delete_servers() :: :ok
  def delete_servers() do
    ServersSupervisor.delete_servers()
  end

  @spec get_server_public_path(pid) :: public_path
  def get_server_public_path(pid) do
    Server.get_public_path(pid)
  end

  @spec get_server_by_public_path(public_path) :: pid | nil
  def get_server_by_public_path(public_path) do
    ServersSupervisor.get_server_pid_by_public_path(public_path)
  end

  defp random_public_path do
    Base.encode32(:crypto.strong_rand_bytes(10))
  end
end
