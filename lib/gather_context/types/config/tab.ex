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
    %{type: "tab", name: name, label: label, hidden: hidden, elements: elements}
  end
end
