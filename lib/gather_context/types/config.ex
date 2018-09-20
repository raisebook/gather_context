defmodule GatherContext.Types.Config do
  @typedoc """
    Represents an GatherContent Config

    Example
    -------
      %GatherContext.Types.Date{
        tabs: []
      }
  """
  @type t :: %__MODULE__{
    tabs: [GatherContext.Types.Config.Tab.t]
  }
  defstruct tabs: []
end
