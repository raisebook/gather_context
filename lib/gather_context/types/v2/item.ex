defmodule GatherContext.Types.V2.Item do
  alias GatherContext.Types.V2.Structure

  defstruct id: nil,
            project_id: nil,
            name: nil,
            template_id: nil,
            structure: %Structure{},
            status_id: nil,
            folder_uuid: nil,
            position: 0
end
