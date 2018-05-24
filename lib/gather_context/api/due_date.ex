defmodule GatherContext.API.DueDate do
  alias GatherContext.API.{DueDate, Date}

  defstruct status_id: nil,
            overdue: false,
            due_date: %Date{}

  def build(json) do
    %DueDate{
      status_id: json["status_id"],
      overdue: json["overdue"],
      due_date: json["due_date"] |> Date.build()
    }
  end
end
