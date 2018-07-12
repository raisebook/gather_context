defmodule GatherContext.Types.Me do
  @typedoc """
    Represents information about the logged in User such as their avatar url, name, and other fields

    Example
    -------
      %GatherContext.Types.Me{
        email: "andrew@gathercontent.com",
        first_name: "Andrew",
        last_name: "Cairns",
        timezone: "UTC",
        language: null,
        gender: null,
        avatar: "http://image-url.com"
      }
  """
  @type t :: %__MODULE__{
    email: binary(),
    first_name: binary(),
    last_name: binary(),
    timezone: binary(),
    language: binary(),
    gender: binary(),
    avatar: binary(),
  }

  defstruct email: nil,
            first_name: nil,
            last_name: nil,
            timezone: nil,
            language: nil,
            gender: nil,
            avatar: nil
end
