defmodule GatherContext.Types.V2.Fields.Guideline do
  use GatherContext.Types.V2.Fields.Field
  alias GatherContext.Types.V2.Fields.{Field, Guideline}

  type("guideline")

  fields()

  def encode(data = %Guideline{}) do
    data |> Field.encode()
  end
end
