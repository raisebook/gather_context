defmodule GatherContext.API.Config do
  alias GatherContext.API.Config
  defstruct tabs: []

  def build(json) do
    %Config{}
  end
end
