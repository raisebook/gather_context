defmodule GatherContext.Types.TemplateUsage do
  @typedoc """
    Represents an GatherContent TemplateUsage

    Example
    -------
      %GatherContext.Types.TemplateUsage{
        item_count: 1
      }
  """
  @type t :: %__MODULE__{
    item_count: integer()
  }
  defstruct item_count: 0
end
