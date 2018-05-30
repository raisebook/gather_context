defmodule GatherContext.Types.Config.ChoiceCheckbox do
  use GatherContext.Types.Config.Element
  type "choice_checkbox"

  fields [:options]

  def encode(%GatherContext.Types.Config.ChoiceCheckbox{options: options}) when length(options) == 0 do
    raise ArgumentError, message: "You need to supply at least one option"
  end

  def encode(data = %GatherContext.Types.Config.ChoiceCheckbox{}) do
    data
    |> GatherContext.Types.Config.Element.encode
    |> Map.merge(%{
      options: GatherContext.Element.encode(data.options)
    })
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config.ChoiceCheckbox do
  def encode(data) do
    GatherContext.Types.Config.ChoiceCheckbox.encode(data)
  end
end
