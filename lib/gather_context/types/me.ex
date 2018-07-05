defmodule GatherContext.Types.Me do
  @type t :: %__MODULE__{
    email: String.t,
    first_name: String.t,
    last_name: String.t,
    timezone: String.t,
    language: String.t,
    gender: String.t,
    avatar: String.t,
  }

  defstruct email: nil,
            first_name: nil,
            last_name: nil,
            timezone: nil,
            language: nil,
            gender: nil,
            avatar: nil
end
