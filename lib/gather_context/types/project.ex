defmodule GatherContext.Types.Project do
  @type t :: %__MODULE__{
    id: Integer.t,
    name: String.t,
    account_id: Integer.t,
    active: Boolean.t,
    text_direction: String.t,
    overdue: Boolean.t,
    statuses: []
  }
  defstruct id: nil,
            name: nil,
            account_id: nil,
            active: false,
            text_direction: nil,
            overdue: nil,
            statuses: []
end
