defmodule GatherContext.API.Project do
  alias GatherContext.API.{Client, Status}
  alias GatherContext.Types.{Account, Project}

  defstruct id: nil,
            name: nil,
            account_id: nil,
            active: false,
            text_direction: nil,
            overdue: nil,
            statuses: []

  def all(client, %Account{id: account_id}) do
    with {:ok, results} <- client |> Client.get("/projects/?account_id=#{account_id}"),
         projects <- results |> Enum.map(&build(&1))
    do
      {:ok, projects}
    else
      error -> error
    end
  end

  def get_project(client, id) when is_integer(id) do
    get_project(client, %Project{id: id})
  end

  def get_project(client, %Project{id: id}) do
    with {:ok, result} <- client |> Client.get("/projects/#{id}"),
         project <- result |> build
    do
      {:ok, project}
    else
      error -> error
    end
  end

  def create(client, account, name) do
    create(client,account, name, "other")
  end

  def create(client, account_id, name, type) when is_integer(account_id) do
    create(client, %Account{id: account_id}, name, type)
  end


  def create(client, %Account{id: account_id}, name, type) when type in ["website-build", "ongoing-website-content", "marketing-editorial-content", "email-marketing-content", "other"] do
    case client |> Client.post("/projects", %{account_id: account_id, name: name, type: type} |> Poison.encode!) do
      {:ok, location} -> {:ok, location |> String.split("/") |> List.last }
      error -> error
    end
  end

  def build(json) do
    %Project{
      id: json["id"],
      name: json["name"],
      account_id: json["account_id"],
      active: json["active"],
      text_direction: json["text_direction"],
      overdue: json["overdue"],
      statuses: json["statuses"]["data"] |> Enum.map(&Status.build(&1))
    }
  end
end
