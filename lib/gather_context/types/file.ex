defmodule GatherContext.Types.File do
  @typedoc """
    Represents an GatherContent File

    Example
    -------
      %GatherContext.Types.File{
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
  defstruct id: nil,
            user_id: nil,
            item_id: nil,
            field: nil,
            type: nil,
            url: nil,
            filename: nil,
            size: nil,
            created_at: nil,
            updated_at: nil
end
