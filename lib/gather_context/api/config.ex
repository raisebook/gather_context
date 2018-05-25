defmodule GatherContext.API.Config do
  alias GatherContext.Types.Config

  def build(_json) do
    %Config{}
  end

  def encode(config) do
    config.tabs
    |> Poison.encode!
    |> Base.encode64()
  end
end
