defmodule WexhookWeb.Components.HookCard do
  @moduledoc """
  A component for displaying a request.
  """

  use Phoenix.Component

  def base(assigns) do
    ~H"""
    <div class="flex items-center justify-between py-2">
      <div class="flex items-center">
        <svg class="w-6 h-6 mr-2 text-teal-500" viewBox="0 0 24 24" fill="none" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7">
          </path>
        </svg>
        <div>
          <p class="text-sm font-medium text-gray-900"><%= @request.method %></p>
          <p class="text-xs text-gray-500"><%= format_date(@request.created_at) %></p>
        </div>
      </div>
    </div>
    <div class="p-2">
      <div class="flex flex-col">
        <p class="text-sm font-medium text-gray-900">Headers:</p>
        <pre class="rounded-md max-h-32 p-2 overflow-auto text-xs text-gray-500 bg-gray-100"><%= inspect(@request.headers) %></pre>
      </div>
      <div class="flex flex-col mt-2">
        <p class="text-sm font-medium text-gray-900">Body:</p>
        <pre class="rounded-md max-h-32 p-2 overflow-auto text-xs text-gray-500 bg-gray-100"><%= inspect(@request.body) %></pre>
      </div>
    </div>
    """
  end

  defp format_date(date) do
    Timex.format!(date, "%F %T", :strftime)
  end
end
