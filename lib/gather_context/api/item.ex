defmodule GatherContext.API.Item do
  alias GatherContext.API.{Client, Config, Date, DueDate, Status}
  alias GatherContext.Types.{Item, Project}

  def all(client, project_id) when is_integer(project_id) do
    all(client, %Project{id: project_id})
  end

  def all(client, %Project{id: project_id}) do
    with {:ok, results} <- client |> Client.get("/items?project_id=#{project_id}"),
         items <- results |> Enum.map(&build(&1))
    do
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
         item <- result |> build
    do
      {:ok, item}
    else
      error -> error
    end
  end

  def choose_status(client, %Item{id: id}, %GatherContext.Types.Status{id: status_id}) do
    client |> Client.post("/items/#{id}/choose_status", URI.encode_query(%{status_id: status_id}))
  end

  def choose_status(client, %Item{id: id}, status_id) when is_integer(status_id) do
    choose_status(client, %Item{id: id}, %GatherContext.Types.Status{id: status_id})
  end

  def choose_status(client, id, %GatherContext.Types.Status{id: status_id}) when is_integer(id) do
    choose_status(client, %Item{id: id}, %GatherContext.Types.Status{id: status_id})
  end

  def choose_status(client, id, status_id) when is_integer(id) and is_integer(status_id) do
    choose_status(client, %Item{id: id}, %GatherContext.Types.Status{id: status_id})
  end

  def apply_template(client, %Item{id: id}, template_id) do
    client |> Client.post("/items/#{id}/apply_template", URI.encode_query(%{template_id: template_id}))
  end

  def apply_template(client, id, template_id) when is_integer(id) do
    apply_template(client, %Item{id: id}, template_id)
  end

  defp build(json) do
    %Item{
      id: json["id"],
      project_id: json["project_id"],
      parent_id: json["parent_id"],
      template_id: json["template_id"],
      position: json["position"] |> String.to_integer,
      name: json["name"],
      config: json["config"] |> Config.build(),
      notes: json["notes"],
      type: json["type"],
      overdue: json["overdue"],
      created_at: json["created_at"] |> Date.build(),
      updated_at: json["updated_at"] |> Date.build(),
      status: json["status"] |> Access.get("data") |> Status.build(),
      due_dates: json["due_dates"] |> Access.get("data") |> Enum.map(&DueDate.build(&1)),
    }
  end
end
