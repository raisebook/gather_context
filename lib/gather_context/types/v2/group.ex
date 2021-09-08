defmodule GatherContext.Types.V2.Group do
  alias GatherContext.Types.V2.Group
  alias GatherContext.Field

  defstruct uuid: nil,
            name: nil,
            fields: []

  def encode(%Group{name: nil}) do
    raise ArgumentError, message: "Name is required"
  end

  def encode(%Group{fields: nil}) do
    raise ArgumentError, message: "Fields are required"
  end

  def encode(data = %Group{}) do
    data
    |> Map.from_struct()
    |> Map.merge(%{
      fields: data.fields |> Field.encode()
    })
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end

  def build(data) do
    %Group{
      uuid: data["uuid"],
      name: data["name"],
      fields: data["fields"] |> Enum.map(&GatherContext.Types.V2.Fields.Field.build/1)
    }
  end
end
