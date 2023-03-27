defmodule WexhookWeb.Components.HookCard do
  @moduledoc """
  A component for displaying a request.
  """

  use Phoenix.Component

  def base(assigns) do
    ~H"""
    <div class="rounded-md dark:bg-gray-800 flex items-center justify-between px-4 py-2 bg-white">
      <div class="flex items-center">
        <svg class="w-6 h-6 mr-2 text-teal-500" viewBox="0 0 24 24" fill="none" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7">
          </path>
        </svg>
        <div>
          <p class="dark:text-gray-100 text-sm font-medium text-gray-900"><%= @request.method %></p>
          <p class="text-xs text-gray-500"><%= format_date(@request.created_at) %></p>
        </div>
      </div>
    </div>
    <div class="rounded-b-md dark:bg-gray-700 p-2 bg-white">
      <div class="flex flex-col">
        <p class="dark:text-gray-100 text-sm font-medium text-gray-900">Headers:</p>
        <pre class="rounded-md max-h-32 dark:text-white dark:bg-gray-600 p-2 overflow-auto text-xs text-gray-500 bg-gray-100"><%= inspect(@request.headers) %></pre>
      </div>
      <div class="flex flex-col mt-2">
        <p class="dark:text-gray-100 text-sm font-medium text-gray-900">Body:</p>
        <pre class="rounded-md max-h-32 dark:text-white dark:bg-gray-600 p-2 overflow-auto text-xs text-gray-500 bg-gray-100"><%= inspect(@request.body) %></pre>
      </div>
    </div>
    """
  end

  defp format_date(date) do
    Timex.format!(date, "%F %T", :strftime)
  end
end
