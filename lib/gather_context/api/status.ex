defmodule GatherContext.API.Status do
  defstruct id: nil,
            is_default: false,
            position: nil,
            color: false,
            name: nil,
            description: nil,
            can_edit: false

  def all(client, %GatherContext.API.Project{id: project_id}) do
    with {:ok, results} <- client.get.("/projects/#{project_id}/statuses"),
         statuses <- results |> Enum.map(&build(&1))
    do
      {:ok, statuses}
    else
      error -> error
    end
  end

  def get_status(client, %GatherContext.API.Project{id: project_id}, id) do
    with {:ok, result} <- client.get.("/projects/#{project_id}/statuses/#{id}"),
         status <- result |> build
    do
      {:ok, status}
    else
      error -> error
    end
  end

  def build(json) do
    %GatherContext.API.Status{
      id: json["id"] |> String.to_integer,
      is_default: json["is_default"],
      position: json["position"] |> String.to_integer,
      color: json["color"],
      name: json["name"],
      description: json["description"],
      can_edit: json["can_edit"]
    }
  end
end
