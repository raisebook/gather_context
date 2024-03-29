defprotocol GatherContext.Field do
  @doc "Encodes the Field, ready for transmission to GatherContent"
  def encode(data)
end

defmodule GatherContext.Types.V2.Fields.Field do
  defmacro __using__(_opts) do
    quote do
      import GatherContext.Types.V2.Fields.Field
      @field_type :unknown
      @before_compile GatherContext.Types.V2.Fields.Field
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      @behaviour GatherContext.Types.V2.Fields.Field

      def type do
        @field_type
      end
    end
  end

  defmacro type(field_type) do
    quote do
      @field_type unquote(field_type)
    end
  end

  defmacro fields() do
    quote do
      defstruct unquote([:uuid, :label, :instructions])
    end
  end

  defmacro fields(field_names) do
    quote do
      defstruct unquote([:uuid, :label, :instructions] ++ field_names)
    end
  end

  alias GatherContext.Types.V2.Fields.Field
  alias GatherContext.Types.V2.Fields

  defstruct uuid: nil,
            label: nil,
            instructions: nil

  @callback encode(struct) :: {:ok, map} | {:error, String.t()}

  def encode(%Field{label: nil}) do
    raise ArgumentError, message: "label is required"
  end

  def encode(%Field{label: ""}) do
    raise ArgumentError, message: "label is required"
  end

  def encode(%Field{uuid: uuid, label: label, instructions: instructions}) do
    %{uuid: uuid, label: label, instructions: instructions}
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end

  def encode(%{__struct__: struct_type} = struct) do
    struct(Field, Map.from_struct(struct))
    |> encode
    |> Map.merge(%{field_type: struct_type.type()})
  end

  defp build_defaults(struct, data) do
    struct
    |> Map.put(:uuid, data["uuid"])
    |> Map.put(:label, data["label"])
    |> Map.put(:instructions, data["instructions"])
  end

  def build(data) do
    case data["type"] do
      "attachment" -> data |> Fields.Attachment.build() |> build_defaults(data)
      "guideline" -> data |> Fields.Guideline.build() |> build_defaults(data)
      "checkbox" -> data |> Fields.Checkbox.build() |> build_defaults(data)
      "component" -> data |> Fields.Component.build() |> build_defaults(data)
      "radio" -> data |> Fields.Radio.build() |> build_defaults(data)
    end
  end
end

defimpl GatherContext.Field, for: List do
  def encode(data) do
    data |> Enum.map(&GatherContext.Field.encode(&1))
  end
end
