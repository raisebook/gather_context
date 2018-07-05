defmodule GatherContext.Types.DueDate do
  alias GatherContext.Types.{Date}

  @typedoc """
    Represents an GatherContent DueDate

    Example
    -------
      %GatherContext.Types.Date{
        status_id: 123456,
        overdue: true,
        due_date: %GatherContext.Types.Date{
          date: "2015-07-31 10:58:12.000000",
          timezone_type: 3,
          timezone: "UTC"
        }
      }
  """
  @type t :: %__MODULE__{
    status_id: integer(),
    overdue: boolean(),
    due_date: GatherContext.Types.Date.t
  }
  defstruct status_id: nil,
            overdue: false,
            due_date: %Date{}
end
