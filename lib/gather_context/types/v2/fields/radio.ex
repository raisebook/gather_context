defmodule GatherContext.Types.V2.Fields.Radio do
  use GatherContext.Types.V2.Fields.Field
  alias GatherContext.Types.V2.Fields.{Field, Radio}
  alias GatherContext.Types.V2.Fields.Radio.Metadata

  type("radio")

  fields([:metadata])

  def encode(data = %Radio{}) do
    data
    |> Field.encode()
    |> Map.merge(%{
      metadata: data.metadata |> Metadata.encode()
    })
  end
end

defmodule GatherContext.Types.V2.Fields.Radio.Metadata do
  alias GatherContext.Types.V2.Fields.Radio.Metadata
  alias GatherContext.Types.V2.Fields.Radio.ChoiceFields

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
end

defmodule GatherContext.Types.V2.Fields.Radio.ChoiceFields do
  alias GatherContext.Types.V2.Fields.Radio.{ChoiceFields, Option}

  defstruct options: [],
            other_options: nil

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
      options: data.options |> Enum.map(&Option.encode(&1)),
      other_options: data.other_options |> Option.encode()
    })
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end
end

defmodule GatherContext.Types.V2.Fields.Radio.Option do
  alias GatherContext.Types.V2.Fields.Radio.Option

  defstruct options_id: [],
            label: nil

  def encode(nil) do
    nil
  end

  def encode(data = %Option{}) do
    data |> Map.from_struct() |> Enum.filter(fn {_, v} -> v != nil end) |> Enum.into(%{})
  end
end
