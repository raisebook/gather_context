defmodule GatherContext.Types.V2.Item do
  alias GatherContext.Types.V2.{Item, Structure}

  defstruct name: nil,
            template_id: nil,
            structure: %Structure{},
            status_id: nil,
            folder_uuid: nil,
            position: 0

  def encode(data = %Item{}) do
    data
    |> Map.from_struct()
    |> Map.merge(%{
      structure: data.structure |> Structure.encode()
    })
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end
end
