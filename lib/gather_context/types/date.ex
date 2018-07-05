defmodule GatherContext.Types.Date do
  @typedoc """
    Represents an GatherContent Date

    Example
    -------
      %GatherContext.Types.Date{
        date: "2015-07-31 10:58:12.000000",
        timezone_type: 3,
        timezone: "UTC"
      }
  """

  @type t :: %__MODULE__{
    date: binary(),
    timezone_type: integer(),
    timezone: binary()
  }
  defstruct date: nil,
            timezone_type: nil,
            timezone: nil
end
