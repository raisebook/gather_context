defmodule GatherContext.Types.DueDate do
  alias GatherContext.Types.{Date}

  defstruct status_id: nil,
            overdue: false,
            due_date: %Date{}
end
