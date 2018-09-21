defmodule GatherContext.API.Config do
  alias GatherContext.Types.Config
  alias GatherContext.Element

  def build(_json) do
    %Config{}
  end

  def encode(config) do
    config
    |> Element.encode
    |> Poison.encode!
    |> Base.encode64()
  end
end
