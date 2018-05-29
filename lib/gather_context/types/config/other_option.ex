defmodule GatherContext.Types.Config.OtherOption do
  defstruct name: "",
            label: "",
            selected: false,
            value: ""

  def encode(%GatherContext.Types.Config.OtherOption{name: ""}) do
    raise ArgumentError, message: "name is required"
  end

  def encode(%GatherContext.Types.Config.OtherOption{label: ""}) do
    raise ArgumentError, message: "label is required"
  end

  def encode(option = %GatherContext.Types.Config.OtherOption{name: name, label: label, selected: false, value: value}) when value != "" do
    encode(%GatherContext.Types.Config.OtherOption{name: name, label: label, selected: false, value: ""})
  end

  def encode(%GatherContext.Types.Config.OtherOption{name: name, label: label, selected: selected, value: value}) do
    %{name: name, label: label, selected: selected, value: value}
  end
end
