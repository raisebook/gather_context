defmodule GatherContext.Types.V2.Item do
  alias GatherContext.Types.V2.{Item, Structure}

  defstruct id: nil,
            project_id: nil,
            name: nil,
            template_id: nil,
            structure_uuid: nil,
            structure: %Structure{},
            status_id: nil,
            folder_uuid: nil,
            position: 0,
            archived_by: nil,
            archived_at: nil,
            created_at: nil,
            updated_at: nil,
            next_due_at: nil,
            completed_at: nil,
            assigned_user_ids: [],
            assignee_count: nil,
            content: nil,
            status_name: nil

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
