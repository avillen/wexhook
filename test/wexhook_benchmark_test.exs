defmodule BenchmarkTest do
  use ExUnit.Case

  alias Wexhook.Request
  alias Wexhook.ServersSupervisor
  alias Wexhook.Support.Strings

  # Comparison:
  # create_servers                7.02
  # get_server_or_create          6.93 - 1.01x slower +1.89 ms
  @tag timeout: :infinity
  @tag :benchmark
  test "creating servers" do
    output =
      Benchee.run(
        %{
          "create_servers" => fn servers_count ->
            Enum.map(1..servers_count, fn _ ->
              id = Strings.random_string()
              {:ok, pid} = ServersSupervisor.start_server(id)

              pid
            end)
          end,
          "get_server_or_create" => fn servers_count ->
            Enum.map(1..servers_count, fn _ ->
              id = Strings.random_string()
              {:ok, pid} = Wexhook.get_server_or_create(id)

              pid
            end)
          end
        },
        inputs: %{
          "input 100" => 100,
          "input 1_000" => 1_000,
          "input 10_000" => 10_000
        },
        after_each: &after_each/1,
        formatters: [
          Benchee.Formatters.HTML,
          Benchee.Formatters.Console
        ]
      )

    results = Enum.at(output.scenarios, 0)
    assert results.run_time_data.statistics.average <= 50_000_000
  end

  # Comparison:
  # adding_requests_without_pubsub                              1.49
  # adding_requests_with_pubsub_sequential                      0.34 - 4.39x slower +2.28 s
  # adding_requests_publishing_pubsub_async_with_start          0.27 - 5.44x slower +2.98 s
  @tag timeout: :infinity
  @tag :benchmark
  test "adding requests to servers" do
    output =
      Benchee.run(
        %{
          "adding_requests_without_pubsub" => fn server_pids ->
            Enum.each(server_pids, fn pid ->
              req = Request.new("id", "GET", [], "", DateTime.utc_now())

              Enum.each(1..length(server_pids), fn _ ->
                Wexhook.ServerRepo.push_request(pid, req)
              end)
            end)

            server_pids
          end,
          "adding_requests_with_pubsub_sequential" => fn server_pids ->
            Enum.each(server_pids, fn pid ->
              req = Request.new("id", "GET", [], "", DateTime.utc_now())

              Enum.each(1..length(server_pids), fn _ ->
                Wexhook.ServerRepo.push_request(pid, req)
                Phoenix.PubSub.broadcast(Wexhook.PubSub, inspect(pid), {:request, req})
              end)
            end)

            server_pids
          end,
          "adding_requests_publishing_pubsub_async_with_start" => fn server_pids ->
            Enum.each(server_pids, fn pid ->
              req = Request.new("id", "GET", [], "", DateTime.utc_now())

              Enum.each(1..length(server_pids), fn _ ->
                Wexhook.ServerRepo.push_request(pid, req)

                Task.start(fn ->
                  Phoenix.PubSub.broadcast(Wexhook.PubSub, inspect(pid), {:request, req})
                end)

                :ok
              end)
            end)

            server_pids
          end
        },
        inputs: %{
          "input 100" => 100,
          "input 1_000" => 1_000
        },
        after_each: &after_each/1,
        before_each: &before_each/1,
        formatters: [
          Benchee.Formatters.HTML,
          Benchee.Formatters.Console
        ]
      )

    results = Enum.at(output.scenarios, 0)
    assert results.run_time_data.statistics.average <= 50_000_000
  end

  # Comparison:
  # fetching_servers_by_id           2.31
  # fetching_servers_by_pid          0.51 - 4.53x slower +1.53 s
  @tag timeout: :infinity
  @tag :benchmark
  test "fetching servers by id" do
    output =
      Benchee.run(
        %{
          "fetching_servers_by_id" => fn servers_data ->
            Enum.map(servers_data, fn {id, pid} ->
              Enum.each(1..length(servers_data), fn _ ->
                Wexhook.get_server_by_id(id)
              end)

              pid
            end)
          end,
          "fetching_servers_by_pid" => fn servers_data ->
            Enum.map(servers_data, fn {_id, pid} ->
              Enum.each(1..length(servers_data), fn _ ->
                Wexhook.get_server_id(pid)
              end)

              pid
            end)
          end
        },
        inputs: %{
          "input 100" => 100,
          "input 1000" => 1_000
        },
        after_each: &after_each/1,
        before_each: &before_each_fetching_servers/1,
        formatters: [
          Benchee.Formatters.HTML,
          Benchee.Formatters.Console
        ]
      )

    results = Enum.at(output.scenarios, 0)
    assert results.run_time_data.statistics.average <= 50_000_000
  end

  defp before_each(servers_count) do
    Enum.map(1..servers_count, fn _ ->
      {:ok, pid} = Wexhook.new_server()
      :ok = Wexhook.subscribe_to_server(pid)

      pid
    end)
  end

  defp after_each(server_pids) do
    Enum.each(server_pids, &Wexhook.delete_server/1)
  end

  defp before_each_fetching_servers(servers_count) do
    Enum.map(1..servers_count, fn _ ->
      {:ok, pid} = Wexhook.new_server()
      id = Wexhook.get_server_id(pid)
      {id, pid}
    end)
  end
end
