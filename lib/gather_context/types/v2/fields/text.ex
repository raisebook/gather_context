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

  def build(data) do
    %Text{
      metadata: Metadata.build(data["metadata"])
    }
  end
end

defmodule GatherContext.Types.V2.Fields.Text.Metadata do
  alias GatherContext.Types.V2.Fields.Text.Metadata
  alias GatherContext.Types.V2.Fields.Text.Metadata.Validation
  alias GatherContext.Types.V2.Fields.Text.Metadata.Repeatable

  defstruct is_plain: false,
            validation: nil,
            repeatable: nil

  def encode(nil) do
    encode(%Metadata{})
  end

  def encode(data = %Metadata{}) do
    data
    |> Map.from_struct()
    |> Map.merge(%{validation: data.validation |> Validation.encode()})
    |> Map.merge(%{repeatable: data.repeatable |> Repeatable.encode()})
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end

  def build(data) do
    %Metadata{
      is_plain: data["is_plain"],
      repeatable: Repeatable.build(data["repeatable"]),
      validation: Validation.build(data["validation"])
    }
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
    data |> Map.from_struct() |> Enum.filter(fn {_, v} -> v != nil end) |> Enum.into(%{})
  end

  def build(data) do
    %Validation{rule: data["rule"], limit: data["limit"]}
  end
end

defmodule GatherContext.Types.V2.Fields.Text.Metadata.Repeatable do
  alias GatherContext.Types.V2.Fields.Text.Metadata.Repeatable

  defstruct is_repeatable: false,
            limit_enabled: false,
            limit: nil

  def encode(nil) do
    nil
  end

  def encode(data = %Repeatable{}) do
    data |> Map.from_struct() |> Enum.filter(fn {_, v} -> v != nil end) |> Enum.into(%{})
  end

  def build(data) do
    %Repeatable{
      is_repeatable: data["is_repeatable"],
      limit_enabled: data["limit_enabled"],
      limit: data["limit"]
    }
  end
end

defimpl GatherContext.Field, for: GatherContext.Types.V2.Fields.Text do
  def encode(data) do
    GatherContext.Types.V2.Fields.Text.encode(data)
  end
end
