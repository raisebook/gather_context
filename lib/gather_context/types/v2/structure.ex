defmodule GatherContext.Types.V2.Structure do
  alias GatherContext.Types.V2.{Structure, Group}

  defstruct uuid: nil,
            groups: []

  def encode(nil) do
    nil
  end

  def encode(%Structure{groups: nil}) do
    raise ArgumentError, message: "Groups are required"
  end

  def encode(data = %Structure{}) do
    data
    |> Map.from_struct()
    |> Map.merge(%{
      groups: data.groups |> Enum.map(&Group.encode/1)
    })
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end
end
