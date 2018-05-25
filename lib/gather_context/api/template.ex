defmodule GatherContext.API.Template do
  alias GatherContext.API.Client
  alias GatherContext.Types.{Template,TemplateUsage}

  def all(client) do
    with {:ok, results} <- client |> Client.get("/templates"),
         templates <- results |> Enum.map(&build(&1))
    do
      {:ok, templates}
    else
      error -> error
    end
  end

  def get_template(client, id) do
    with {:ok, result} <- client |> Client.get("/templates/#{id}"),
         template <- result |> build
    do
      {:ok, template}
    else
      error -> error
    end
  end

  defp build(json) do
    %Template{
      id: json["id"],
      project_id: json["project_id"],
      created_by: json["created_by"],
      updated_by: json["updated_by"],
      name: json["name"],
      description: json["description"],
      used_at: json["used_at"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
      usage: %TemplateUsage{item_count: json["usage"]["item_count"]}
    }
  end
end
