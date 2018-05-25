defmodule GatherContext.Types.Project do
  defstruct id: nil,
            name: nil,
            account_id: nil,
            active: false,
            text_direction: nil,
            overdue: nil,
            statuses: []
end
