defmodule GatherContext.API.V2.Item do
  alias GatherContext.API.V2.Client
  alias GatherContext.API.{Config}
  alias GatherContext.Types.V2.{Item, Structure}
  alias GatherContext.Types.Project

  def all(client, project_id) when is_integer(project_id) do
    all(client, %Project{id: project_id})
  end

  def all(client, %Project{id: project_id}) do
    with {:ok, results} <- client |> Client.get("/items?project_id=#{project_id}"),
         items <- results |> Enum.map(&build(&1)) do
      {:ok, items}
    else
      error -> error
    end
  end

  def get_item(client, id) when is_integer(id) do
    get_item(client, %Item{id: id})
  end

  def get_item(client, %Item{id: id}) do
    with {:ok, result} <- client |> Client.get("/items/#{id}"),
         item <- result |> build do
      {:ok, item}
    else
      error -> error
    end
  end

  def create(client, project, name) do
    create(client, project, name, [])
  end

  defp config_encode(payload) do
    case payload |> Access.get(:config) do
      nil -> payload
      config -> payload |> List.keyreplace(:config, 0, {:config, Config.encode(config)})
    end
  end

  def create(client, %Project{id: project_id}, name, optionals) do
    query =
      ([project_id: project_id, name: name] ++ optionals)
      |> Enum.reject(&is_nil/1)
      |> config_encode
      |> Map.new()
      |> Poison.encode!()

    case client |> Client.post("/items", query) do
      {:ok, location} ->
        {:ok, location |> String.split("/") |> List.last() |> String.to_integer()}

      error ->
        error
    end
  end

  def create(client, project_id, name, optionals) when is_integer(project_id) do
    create(client, %Project{id: project_id}, name, optionals)
  end

  def apply_template(client, %Item{id: id}, template_id) do
    client
    |> Client.post("/items/#{id}/apply_template", %{template_id: template_id} |> Poison.encode!())
  end

  def apply_template(client, id, template_id) when is_integer(id) do
    apply_template(client, %Item{id: id}, template_id)
  end

  def disconnect_template(client, %Item{id: id}, template_id) do
    client
    |> Client.post(
      "/items/#{id}/disconnect_template",
      %{template_id: template_id} |> Poison.encode!()
    )
  end

  def disconnect_template(client, id, template_id) when is_integer(id) do
    disconnect_template(client, %Item{id: id}, template_id)
  end

  def save(client, %Item{id: id}, config) do
    encoded = Config.encode(config)

    client |> Client.post("/items/#{id}/save", %{config: encoded} |> Poison.encode!())
  end

  def save(client, id, config) when is_integer(id) do
    save(client, %Item{id: id}, config)
  end

  defp build(json) do
    %Item{
      id: json["id"],
      project_id: json["project_id"],
      status_id: json["status_id"],
      folder_uuid: json["folder_uuid"],
      template_id: json["template_id"],
      structure_uuid: json["structure_uuid"],
      structure: Structure.build(json["structure"]),
      position: json["position"] |> String.to_integer(),
      name: json["name"],
      archived_by: json["archived_by"] |> String.to_integer(),
      archived_at: json["archived_at"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
      next_due_at: json["next_due_at"],
      completed_at: json["completed_at"],
      assigned_user_ids: json["assigned_user_ids"] |> Enum.map(&String.to_integer/1),
      assignee_count: json["assignee_count"] |> String.to_integer(),
      content: json["content"]
    }
  end
end
