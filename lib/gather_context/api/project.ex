defmodule GatherContext.API.Project do
  alias GatherContext.API.{Project,Account, Status}

  defstruct id: nil,
            name: nil,
            account_id: nil,
            active: false,
            text_direction: nil,
            overdue: nil,
            statuses: []

  def all(client, %Account{id: account_id}) do
    with {:ok, results} <- client.get.("/projects/?account_id=#{account_id}"),
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
    with {:ok, result} <- client.get.("/projects/#{id}"),
         project <- result |> build
    do
      {:ok, project}
    else
      error -> error
    end
  end

  def build(json) do
    %GatherContext.API.Project{
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
