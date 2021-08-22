defmodule GatherContext.Types.V2.Fields.Attachment do
  use GatherContext.Types.V2.Fields.Field
  alias GatherContext.Types.V2.Fields.{Field, Attachment}

  type("attachment")

  fields()

  def encode(data = %Attachment{}) do
    data |> Field.encode()
  end
end

defimpl GatherContext.Field, for: GatherContext.Types.V2.Fields.Attachment do
  def encode(data) do
    GatherContext.Types.V2.Fields.Attachment.encode(data)
  end
end
