defmodule WexhookWeb.Components.HookCard do
  @moduledoc """
  A component for displaying a request.
  """

  use Phoenix.Component

  def base(assigns) do
    ~H"""
    <div class="flex items-center justify-between">
      <div class="flex-shrink-0">
        <svg
          class="w-5 h-5 text-gray-400"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7">
          </path>
        </svg>
      </div>
      <div class="divide-y flex flex-col ml-4">
        <div class="text-sm font-bold text-gray-900">
          <%= format_date(@request.created_at) %>
        </div>
        <div class="text-sm font-medium text-gray-900"><%= @request.method %></div>
        <div class="text-sm font-medium text-gray-900"><%= inspect(@request.headers) %></div>
        <div class="text-sm font-semibold text-gray-900"><%= inspect(@request.body) %></div>
      </div>
    </div>
    """
  end

  defp format_date(date) do
    Timex.format!(date, "%F %T", :strftime)
  end
end
