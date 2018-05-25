defmodule GatherContext.API.File do
  alias GatherContext.Types.{File, Item}

  def get(client, %Item{id: item_id}) do
    case client.get.("/items/#{item_id}/files") do
      {:ok, files} -> {:ok, files |> Enum.map(&build(&1))}
      error -> error
    end
  end

  defp build(json) do
    %File{
      id: json["id"],
      user_id: json["user_id"],
      item_id: json["item_id"],
      field: json["field"],
      type: json["type"] |> String.to_integer,
      url: json["url"],
      filename: json["filename"],
      size: json["size"],
      created_at: json["created_at"],
      updated_at: json["updated_at"]
    }
  end
end
