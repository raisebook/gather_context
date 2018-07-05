defmodule GatherContext.API.Project do
  alias GatherContext.API.{Client, Status}
  alias GatherContext.Types.{Account, Project}

  @moduledoc """
    Information about the GatherContent projects with in an account
  """

  @doc """
    Retrieves a list of all Projects associated with the given Account.
  """
  @spec all(GatherContext.API.Client.t, GatherContext.Type.Account.t) :: {:ok, [GatherContext.Types.Project.t]}
  @spec all(GatherContext.API.Client.t, GatherContext.Type.Account.t) :: {:error, String.t}
  @spec all(GatherContext.API.Client.t, GatherContext.Type.Account.t) :: {:unauthorized}
  @spec all(GatherContext.API.Client.t, GatherContext.Type.Account.t) :: {:not_found}
  def all(client, %Account{id: account_id}) do
    with {:ok, results} <- client |> Client.get("/projects/?account_id=#{account_id}"),
         projects <- results |> Enum.map(&build(&1))
    do
      {:ok, projects}
    else
      error -> error
    end
  end

  @doc """
    This retrieves all information for a specific Project.
  """
  @spec get_project(GatherContext.API.Client.t, Integer.t) :: {:ok, GatherContext.Types.Project.t}
  @spec get_project(GatherContext.API.Client.t, Integer.t) :: {:error, String.t}
  @spec get_project(GatherContext.API.Client.t, Integer.t) :: {:unauthorized}
  @spec get_project(GatherContext.API.Client.t, Integer.t) :: {:not_found}
  def get_project(client, id) when is_integer(id) do
    get_project(client, %Project{id: id})
  end

  @spec get_project(GatherContext.API.Client.t, GatherContext.Type.Project.t) :: {:ok, GatherContext.Types.Project.t}
  @spec get_project(GatherContext.API.Client.t, GatherContext.Type.Project.t) :: {:error, String.t}
  @spec get_project(GatherContext.API.Client.t, GatherContext.Type.Project.t) :: {:unauthorized}
  @spec get_project(GatherContext.API.Client.t, GatherContext.Type.Project.t) :: {:not_found}
  def get_project(client, %Project{id: id}) do
    with {:ok, result} <- client |> Client.get("/projects/#{id}"),
         project <- result |> build
    do
      {:ok, project}
    else
      error -> error
    end
  end

  @doc """
    Creates a new Project for a specific Account.

    When you create a Project, a default Workflow containing four Statuses will be created and associated with it. As part of this request a type can be passed as an argument to specify the project type.

    Available options for the project types are :

    * website-build
    * ongoing-website-content
    * marketing-editorial-content
    * email-marketing-content
    * other
  """
  def create(client, account, name) do
    create(client, account, name, "other")
  end

  def create(client, account_id, name, type) when is_integer(account_id) do
    create(client, %Account{id: account_id}, name, type)
  end


  def create(client, %Account{id: account_id}, name, type) when type in ["website-build", "ongoing-website-content", "marketing-editorial-content", "email-marketing-content", "other"] do
    client |> Client.post("/projects", URI.encode_query(%{account_id: account_id, name: name, type: type}))
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
