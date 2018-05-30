defmodule GatherContext.Types.Config.ChoiceRadio do
  use GatherContext.Types.Config.Element
  alias GatherContext.Types.Config.{ChoiceRadio,Element, OtherOption}

  type "choice_radio"

  fields other_option: false,
         options: []

  defp check_other_options_length(other_options, other_option) when other_option == true and length(other_options) != 1 do
    raise ArgumentError, message: "The must include a GatherContext.Types.Config.OtherOption if other_option = true"
  end

  defp check_other_options_length(other_options, other_option) when other_option == false and length(other_options) != 0 do
    raise ArgumentError, message: "The can't include a GatherContext.Types.Config.OtherOption if other_option = false"
  end

  defp check_other_options_length(other_options, _other_option) do
    other_options
  end

  defp check_other_options_validity(options, other_option) do
    check_other_options_length(options |> Enum.filter(fn(option) -> option.__struct__ == OtherOption end), other_option)
    options
  end

  defp check_selected_options_length(selected) when length(selected) > 1 do
    raise ArgumentError, message: "You can't select more than one ChoiceRadio Option"
  end

  defp check_selected_options_length(selected) do
    selected
  end

  defp check_options_validity(options) do
    check_selected_options_length(options |> Enum.filter(fn(option) -> option.selected end))

    options
  end

  defp sort_options(options) do
    other_option = options |> Enum.filter(fn(option) -> option.__struct__ == OtherOption end)

    case other_option do
      nil -> options
      _ -> (options |> Enum.reject(fn(option) -> option.__struct__ == OtherOption end)) ++ other_option
    end
  end

  defp encode_options(options, other_option) do
    options
    |> check_options_validity
    |> check_other_options_validity(other_option)
    |> sort_options
    |> GatherContext.Element.encode
  end

  def encode(%ChoiceRadio{options: options}) when length(options) == 0 do
    raise ArgumentError, message: "You need to supply at least one option"
  end

  def encode(data = %ChoiceRadio{}) do
    data
    |> Element.encode
    |> Map.merge(%{
      other_option: data.other_option,
      options: encode_options(data.options, data.other_option)
    })
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config.ChoiceRadio do
  def encode(data) do
    GatherContext.Types.Config.ChoiceRadio.encode(data)
  end
end
