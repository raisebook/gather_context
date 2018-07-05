defmodule GatherContext.Types.Status do
  @type t :: %__MODULE__{
    id: integer(),
    is_default: boolean(),
    position: integer(),
    color: boolean(),
    name: String.t,
    description: String.t,
    can_edit: boolean()
  }
  defstruct id: nil,
            is_default: false,
            position: nil,
            color: false,
            name: nil,
            description: nil,
            can_edit: false
end
