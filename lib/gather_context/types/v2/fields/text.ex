defmodule GatherContext.Types.V2.Fields.Text do
  use GatherContext.Types.V2.Fields.Field
  alias GatherContext.Types.V2.Fields.{Field, Text}
  alias GatherContext.Types.V2.Fields.Text.Metadata

  type("text")

  fields([:metadata])

  def encode(data = %Text{}) do
    data
    |> Field.encode()
    |> Map.merge(%{
      metadata: data.metadata |> Metadata.encode()
    })
  end
end

defmodule GatherContext.Types.V2.Fields.Text.Metadata do
  alias GatherContext.Types.V2.Fields.Text.Metadata
  alias GatherContext.Types.V2.Fields.Text.Metadata.Validation

  defstruct is_plain: false,
            validation: nil

  def encode(nil) do
    encode(%Metadata{})
  end

  def encode(data = %Metadata{}) do
    data
    |> Map.from_struct()
    |> Map.merge(%{validation: data.validation |> Validation.encode()})
    |> Enum.filter(fn {_, v} -> v != nil end)
  end
end

defmodule GatherContext.Types.V2.Fields.Text.Metadata.Validation do
  alias GatherContext.Types.V2.Fields.Text.Metadata.Validation

  defstruct rule: "chars",
            limit: nil

  def encode(nil) do
    nil
  end

  def encode(data = %Validation{}) do
    data |> Map.from_struct() |> Enum.filter(fn {_, v} -> v != nil end)
  end
end
