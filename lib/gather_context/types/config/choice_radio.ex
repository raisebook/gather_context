defmodule GatherContext.Types.Config.ChoiceRadio do
  use GatherContext.Types.Config.Element
  type "choice_radio"

  fields [:other_option, :options]

  def encode(data = %GatherContext.Types.Config.ChoiceCheckbox{}) do
    data
    |> GatherContext.Types.Config.Element.encode
    |> Map.merge(%{
      options: data.options
    })
  end
end
