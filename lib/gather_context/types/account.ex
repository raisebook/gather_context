defmodule GatherContext.Types.Account do
  @typedoc """
    Represents an Account in GatherContent

    Example
    -------
      %GatherContext.Types.Account{
        id: 123456,
        name: "Example",
        slug: "example",
        timezone: "UTC"
      }
  """
  @type t :: %__MODULE__{
    id: integer(),
    name: binary(),
    slug: binary(),
    timezone: binary()
  }

  defstruct id:       nil,
            name:     nil,
            slug:     nil,
            timezone: nil
end
