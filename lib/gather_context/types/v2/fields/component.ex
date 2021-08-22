defmodule GatherContext.Types.V2.Fields.Component do
  use GatherContext.Types.V2.Fields.Field
  alias GatherContext.Types.V2.Structure
  alias GatherContext.Types.V2.Fields.{Field, Component}
  alias GatherContext.Types.V2.Fields.Component.Metadata

  type("component")

  fields([:metadata, :structure, :component])

  def encode(data = %Component{}) do
    data
    |> Field.encode()
    |> Map.merge(%{
      component: data.component,
      metadata: data.metadata |> Metadata.encode(),
      structure: data.structure |> Structure.encode()
    })
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end
end

defmodule GatherContext.Types.V2.Fields.Component.Metadata do
  alias GatherContext.Types.V2.Fields.Component.Metadata
  alias GatherContext.Types.V2.Fields.Component.Metadata.Repeatable

  defstruct repeatable: nil

  def encode(nil) do
    nil
  end

  def encode(data = %Metadata{}) do
    data
    |> Map.from_struct()
    |> Map.merge(%{repeatable: data.repeatable |> Repeatable.encode()})
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end
end

defmodule GatherContext.Types.V2.Fields.Component.Metadata.Repeatable do
  alias GatherContext.Types.V2.Fields.Component.Metadata.Repeatable

  defstruct is_repeatable: false,
            limit_enabled: false,
            limit: nil

  def encode(nil) do
    nil
  end

  def encode(data = %Repeatable{}) do
    data |> Map.from_struct() |> Enum.filter(fn {_, v} -> v != nil end) |> Enum.into(%{})
  end
end

defimpl GatherContext.Field, for: GatherContext.Types.V2.Fields.Component do
  def encode(data) do
    GatherContext.Types.V2.Fields.Component.encode(data)
  end
end
