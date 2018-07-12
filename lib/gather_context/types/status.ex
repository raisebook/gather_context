defmodule GatherContext.Types.Status do
  @typedoc """
    Represents an GatherContent Status

    Example
    -------
      %GatherContext.Types.Status{
        id: "123456",
        is_default: true,
        position: 1,
        color: "#C5C5C5",
        name: "Draft",
        description: "",
        can_edit: true
      }
  """
  @type t :: %__MODULE__{
    id: integer(),
    is_default: boolean(),
    position: integer(),
    color: boolean(),
    name: binary(),
    description: binary(),
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
