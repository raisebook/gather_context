defprotocol GatherContext.Element do
  @doc "Encodes the Element, ready for transmission to GatherContent"
  def encode(data)
end

defmodule GatherContext.Types.Config.Element do
  defmacro __using__(_opts) do
    quote do
      import GatherContext.Types.Config.Element
      @element_type :unknown
      @before_compile GatherContext.Types.Config.Element
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      @behaviour GatherContext.Types.Config.Element

      def type do
        @element_type
      end
    end
  end

  defmacro type(element_type) do
    quote do
      @element_type unquote(element_type)
    end
  end

  defmacro fields(field_names) do
    quote do
      defstruct unquote([name: "", required: false, label: "", microcopy: ""] ++ field_names)
    end
  end

  alias GatherContext.Types.Config

  defstruct name: "",
            required: false,
            label: "",
            microcopy: ""

  @callback encode(struct) :: {:ok, map} | {:error, String.t}

  def encode(%Config.Element{name: ""}) do
    raise ArgumentError, message: "name is required"
  end

  def encode(%Config.Element{label: ""}) do
    raise ArgumentError, message: "label is required"
  end

  def encode(%Config.Element{name: name, required: required, label: label, microcopy: microcopy}) do
    %{name: name, required: required, label: label, microcopy: microcopy}
  end

  def encode(%{__struct__: struct_type} = struct) do
    struct(Config.Element, Map.from_struct(struct))
    |> encode
    |> Map.merge(%{type: struct_type.type()})
  end

  defp build_defaults(struct, data) do
    struct
    |> Map.put(:name, data["name"])
    |> Map.put(:required, data["required"])
    |> Map.put(:label, data["label"])
    |> Map.put(:microcopy, data["microcopy"])
  end

  def build(data) do
    case data["type"] do
      "section" -> Config.Section.build(data)
      "text" -> Config.Text.build(data) |> build_defaults(data)
      "files" -> Config.Files.build(data) |> build_defaults(data)
      "choice_radio" -> Config.ChoiceRadio.build(data) |> build_defaults(data)
      "choice_checkbox" -> Config.ChoiceCheckbox.build(data) |> build_defaults(data)
    end
  end
end

defimpl GatherContext.Element, for: List do
  def encode(data) do
    data |> Enum.map(&GatherContext.Element.encode(&1))
  end
end
