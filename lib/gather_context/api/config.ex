defmodule GatherContext.API.Config do
  alias GatherContext.Types.Config
  alias GatherContext.Element

  def build(json) do
    json
    |> Config.build
  end

  def encode(config) do
    config
    |> Element.encode
    |> Poison.encode!
    |> Base.encode64()
  end
end
