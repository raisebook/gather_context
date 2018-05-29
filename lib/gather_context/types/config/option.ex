defmodule GatherContext.Types.Config.Option do
  @behaviour GatherContext.Types.Config.Element

  defstruct name: "",
            label: "",
            selected: false

  def encode(%GatherContext.Types.Config.Option{name: ""}) do
    raise ArgumentError, message: "name is required"
  end

  def encode(%GatherContext.Types.Config.Option{label: ""}) do
    raise ArgumentError, message: "label is required"
  end

  def encode(%GatherContext.Types.Config.Option{name: name, label: label, selected: selected}) do
    %{name: name, label: label, selected: selected}
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config.Option do
  def encode(data) do
    data |> GatherContext.Types.Config.Option.encode()
  end
end
