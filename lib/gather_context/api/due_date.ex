defmodule GatherContext.API.DueDate do
  alias GatherContext.Types.DueDate
  alias GatherContext.API.Date

  def build(json) do
    %DueDate{
      status_id: json["status_id"],
      overdue: json["overdue"],
      due_date: json["due_date"] |> Date.build()
    }
  end
end
