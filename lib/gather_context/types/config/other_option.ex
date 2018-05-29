defmodule GatherContext.Types.Config.OtherOption do
  alias GatherContext.Types.Config.OtherOption
  defstruct name: "",
            label: "",
            selected: false,
            value: ""

  def encode(%OtherOption{name: ""}) do
    raise ArgumentError, message: "name is required"
  end

  def encode(%OtherOption{label: ""}) do
    raise ArgumentError, message: "label is required"
  end

  def encode(%OtherOption{name: name, label: label, selected: false, value: value}) when value != "" do
    encode(%OtherOption{name: name, label: label, selected: false, value: ""})
  end

  def encode(%OtherOption{name: name, label: label, selected: selected, value: value}) do
    %{name: name, label: label, selected: selected, value: value}
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config.OtherOption do
  def encode(data) do
    GatherContext.Types.Config.OtherOption.encode(data)
  end
end
