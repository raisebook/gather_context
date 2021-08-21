defmodule GatherContext.Types.V2.Structure do
  alias GatherContext.Types.V2.Structure

  defstruct uuid: nil

  def encode(nil) do
    nil
  end

  def encode(data = %Structure{}) do
    data
    |> Map.from_struct()
    |> Enum.into(%{})
  end
end
