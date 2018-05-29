defmodule GatherContext.Types.Config.ChoiceRadio do
  use GatherContext.Types.Config.Element
  type "choice_radio"

  fields other_option: false,
         options: []

  def encode(%GatherContext.Types.Config.ChoiceRadio{options: options}) when length(options) == 0 do
    raise ArgumentError, message: "You need to supply at least one option"
  end

  def encode(data = %GatherContext.Types.Config.ChoiceRadio{}) do
    data
    |> GatherContext.Types.Config.Element.encode
    |> Map.merge(%{
      other_option: data.other_option,
      options: GatherContext.Element.encode(data.options)
    })
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config.ChoiceRadio do
  def encode(data) do
    GatherContext.Types.Config.ChoiceRadio.encode(data)
  end
end
