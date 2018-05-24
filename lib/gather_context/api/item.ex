defmodule GatherContext.API.Item do
  alias GatherContext.API.{Item, Project, Config, Date, Status, DueDate}

  defstruct id: nil,
            project_id: nil,
            parent_id: nil,
            template_id: nil,
            position: 0,
            name: nil,
            config: %Config{},
            notes: nil,
            type: "item",
            overdue: false,
            created_at: %Date{},
            updated_at: %Date{},
            status: %Status{},
            due_dates: %DueDate{}

  def all(client, %Project{id: project_id}) do
    with {:ok, results} <- client.get.("/items?project_id=#{project_id}"),
         items <- results |> Enum.map(&build(&1))
    do
      {:ok, items}
    else
      error -> error
    end
  end

  def all(client, project_id) when is_integer(project_id) do
    all(client, %Project{id: project_id})
  end

  def get_item(client, id) do
    with {:ok, result} <- client.get.("/items/#{id}"),
         item <- result |> build
    do
      {:ok, item}
    else
      error -> error
    end
  end

  defp build(json) do
    %Item{
      id: json["id"],
      project_id: json["project_id"],
      parent_id: json["parent_id"],
      template_id: json["template_id"],
      position: json["position"] |> String.to_integer,
      name: json["name"],
      config: json["config"] |> Access.get("data") |> Config.build(),
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
