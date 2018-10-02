defmodule GatherContext.Types.Config.Tab do
  @behaviour GatherContext.Types.Config.Element

  defstruct name: nil,
            label: nil,
            hidden: false,
            elements: []

  def encode(%GatherContext.Types.Config.Tab{name: ""}) do
    raise ArgumentError, message: "name is required"
  end

  def encode(%GatherContext.Types.Config.Tab{label: ""}) do
    raise ArgumentError, message: "label is required"
  end

  def encode(%GatherContext.Types.Config.Tab{name: name, label: label, hidden: hidden, elements: elements}) do
    %{name: name, label: label, hidden: hidden, elements: GatherContext.Element.encode(elements)}
  end

  def build(data) do
    %GatherContext.Types.Config.Tab{
      name: data["name"],
      label: data["label"],
      hidden: data["hidden"],
      elements: data["elements"] |> Enum.map(&GatherContext.Types.Config.Element.build(&1))
    }
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config.Tab do
  def encode(data) do
    GatherContext.Types.Config.Tab.encode(data)
  end
end
