defmodule GatherContext.Types.V2.Fields.Checkbox do
  use GatherContext.Types.V2.Fields.Field
  alias GatherContext.Types.V2.Fields.{Field, Checkbox}
  alias GatherContext.Types.V2.Fields.Checkbox.Metadata

  type("checkbox")

  fields([:metadata])

  def encode(data = %Checkbox{}) do
    data
    |> Field.encode()
    |> Map.merge(%{
      metadata: data.metadata |> Metadata.encode()
    })
  end

  def build(data) do
    %Checkbox{metadata: Metadata.build(data["metadata"])}
  end
end

defmodule GatherContext.Types.V2.Fields.Checkbox.Metadata do
  alias GatherContext.Types.V2.Fields.Checkbox.Metadata
  alias GatherContext.Types.V2.Fields.Checkbox.ChoiceFields

  defstruct choice_fields: nil

  def encode(nil) do
    raise ArgumentError, message: "metadata is required"
  end

  def encode(data = %Metadata{}) do
    data
    |> Map.from_struct()
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
    |> Map.merge(%{
      choice_fields: data.choice_fields |> ChoiceFields.encode()
    })
  end

  def build(data) do
    %Metadata{choice_fields: ChoiceFields.build(data["choice_fields"])}
  end
end

defmodule GatherContext.Types.V2.Fields.Checkbox.ChoiceFields do
  alias GatherContext.Types.V2.Fields.Checkbox.{ChoiceFields, Option}

  defstruct options: []

  def encode(nil) do
    raise ArgumentError, message: "choice_fields is required"
  end

  def encode(%ChoiceFields{options: nil}) do
    raise ArgumentError, message: "options are required"
  end

  def encode(%ChoiceFields{options: []}) do
    raise ArgumentError, message: "options can't be empty"
  end

  def encode(data = %ChoiceFields{}) do
    data
    |> Map.from_struct()
    |> Map.merge(%{
      options: data.options |> Enum.map(&Option.encode(&1))
    })
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end

  def build(data) do
    %ChoiceFields{options: data["options"] |> Enum.map(&Option.build/1)}
  end
end

defmodule GatherContext.Types.V2.Fields.Checkbox.Option do
  alias GatherContext.Types.V2.Fields.Checkbox.Option

  defstruct options_id: [],
            label: nil

  def encode(nil) do
    nil
  end

  def encode(data = %Option{}) do
    data |> Map.from_struct() |> Enum.filter(fn {_, v} -> v != nil end) |> Enum.into(%{})
  end

  def build(data) do
    %Option{options_id: data["options_id"], label: data["label"]}
  end
end

defimpl GatherContext.Field, for: GatherContext.Types.V2.Fields.Checkbox do
  def encode(data) do
    GatherContext.Types.V2.Fields.Checkbox.encode(data)
  end
end
