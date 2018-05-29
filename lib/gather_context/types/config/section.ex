defmodule GatherContext.Types.Config.Section do
  @behaviour GatherContext.Types.Config.Element

  defstruct name: "", title: "", subtitle: ""

  def encode(%GatherContext.Types.Config.Section{name: ""}) do
    raise ArgumentError, message: "name is required"
  end

  def encode(%GatherContext.Types.Config.Section{title: ""}) do
    raise ArgumentError, message: "title is required"
  end

  def encode(%GatherContext.Types.Config.Section{name: name, title: title, subtitle: subtitle}) do
    %{type: "section", name: name, title: title, subtitle: subtitle}
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config.Section do
  def encode(data) do
    GatherContext.Types.Config.Section.encode(data)
  end
end
