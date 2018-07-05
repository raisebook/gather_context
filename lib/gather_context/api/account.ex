defmodule GatherContext.API.Account do
  alias GatherContext.API.Client
  alias GatherContext.Types.Account

  @moduledoc """
    Information about the GatherContent accounts linked to your login
  """

  @doc """
    Retrieves a list of all Accounts associated with a specific User in GatherContent
  """
  @spec all(GatherContext.API.Client.t) :: {:ok, [GatherContext.Types.Account.t]}
  @spec all(GatherContext.API.Client.t) :: {:error, String.t}
  @spec all(GatherContext.API.Client.t) :: {:unauthorized}
  def all(client) do
    with {:ok, results} <- client |> Client.get("/accounts"),
         accounts <- results |> Enum.map(&build(&1))
    do
      {:ok, accounts}
    else
      error -> error
    end
  end

  @doc """
    Retrieves information about a specific Account associated with the authenticated User in GatherContent
  """
  @spec get_account(GatherContext.API.Client.t, Integer.t) :: {:ok, GatherContext.Types.Account.t}
  @spec get_account(GatherContext.API.Client.t, Integer.t) :: {:error, String.t}
  @spec get_account(GatherContext.API.Client.t, Integer.t) :: {:unauthorized}
  @spec get_account(GatherContext.API.Client.t, Integer.t) :: {:not_found}
  def get_account(client, id) do
    with {:ok, result} <- client |> Client.get("/accounts/#{id}"),
         account <- result |> build
    do
      {:ok, account}
    else
      error -> error
    end
  end

  defp build(json) do
    %Account{
      id: json["id"] |> String.to_integer,
      name: json["name"],
      slug: json["slug"],
      timezone: json["timezone"]
    }
  end
end
