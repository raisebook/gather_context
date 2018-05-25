defmodule GatherContext.Types.Item do
  alias GatherContext.Types.{Config, Date, DueDate, Status}

  defstruct id: nil,
            project_id: nil,
            parent_id: nil,
            template_id: nil,
            position: 0,
            name: nil,
            config: %Config{},
            notes: nil,
            type: "item",
            overdue: false,
            created_at: %Date{},
            updated_at: %Date{},
            status: %Status{},
            due_dates: %DueDate{}
end
