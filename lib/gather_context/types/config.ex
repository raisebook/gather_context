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

  def encode(%GatherContext.Types.Config{tabs: tabs}) do
    tabs
    |> GatherContext.Element.encode
  end

  def build(data) do
    case data do
      nil -> nil
      data -> %GatherContext.Types.Config{ tabs: data |> Enum.map(&GatherContext.Types.Config.Tab.build(&1)) }
    end
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config do
  def encode(data) do
    GatherContext.Types.Config.encode(data)
  end
end
