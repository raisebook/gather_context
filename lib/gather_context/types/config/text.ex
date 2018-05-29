defmodule GatherContext.Types.Config.Text do
  alias GatherContext.Types.Config.{Element, Text}
  use Element

  type "text"
  fields value: "",
         limit_type: :chars,
         limit: 0,
         plain_text: true

  def encode(%Text{limit_type: limit_type}) when limit_type not in [:words, :chars] do
    raise ArgumentError, message: "limit_type is can only be :words or :chars"
  end

  def encode(%Text{limit: limit}) when limit < 0 do
    raise ArgumentError, message: "limit must be a positive number"
  end

  def encode(data = %Text{}) do
    data
    |> Element.encode
    |> Map.merge(%{
      value: data.value,
      limit_type: data.limit_type,
      limit: data.limit,
      plain_text: data.plain_text
    })
  end
end

defimpl GatherContext.Element, for: GatherContext.Types.Config.Text do
  def encode(data) do
    GatherContext.Types.Config.Text.encode(data)
  end
end
