defmodule WexhookWeb.Components.DarkmodeToggle do
  @moduledoc """
  A component for displaying a toggle to enable and disable dark mode.
  """
  alias Phoenix.LiveView.JS

  use Phoenix.Component

  def base(assigns) do
    ~H"""
    <div class="flex items-center justify-end">
      <span class="dark:text-gray-300 pr-3 text-black">Light</span>
      <div class="transition duration-200 ease-in relative inline-block w-10 mr-2 align-middle select-none">
        <input
          type="checkbox"
          name="toggle"
          id="toggle"
          class="toggle-checkbox dark:bg-gray-500 absolute block w-6 h-6 bg-white border-4 rounded-full appearance-none cursor-pointer"
          phx-click={JS.dispatch("toogle-darkmode")}
        />
        <label
          for="toggle"
          class="toggle-label dark:bg-gray-600 block h-6 overflow-hidden bg-gray-300 rounded-full cursor-pointer"
        >
        </label>
      </div>
      <span class="dark:text-gray-300 pl-3 text-black">Dark</span>
    </div>
    """
  end
end
