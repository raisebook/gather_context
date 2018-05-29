defmodule GatherContext.Types.Config.Files do
  alias GatherContext.Types.Config.{Element, Files}
  use Element

  type "files"
  fields []

  def encode(data = %Files{}) do
    data
    |> Element.encode
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config.Files do
  def encode(data) do
    GatherContext.Types.Config.Files.encode(data)
  end
end
