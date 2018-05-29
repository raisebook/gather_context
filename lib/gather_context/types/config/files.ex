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
