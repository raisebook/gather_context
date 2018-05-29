defmodule GatherContext.Types.Config.ChoiceCheckbox do
  use GatherContext.Types.Config.Element
  type "choice_checkbox"

  fields [:options]

  def encode(data = %GatherContext.Types.Config.ChoiceCheckbox{}) do
    data
    |> GatherContext.Types.Config.Element.encode
    |> Map.merge(%{
      options: data.options
    })
  end
end
