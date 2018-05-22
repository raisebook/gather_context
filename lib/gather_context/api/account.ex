defmodule GatherContext.API.Account do
  defstruct id:       nil,
            name:     nil,
            slug:     nil,
            timezone: nil

  def all(client) do
    with {:ok, results} <- client.get.("/accounts"),
         accounts <- results |> Enum.map(&build(&1))
    do
      {:ok, accounts}
    else
      error -> error
    end
  end

  def get_account(client, id) do
    with {:ok, result} <- client.get.("/accounts/#{id}"),
         account <- result |> build
    do
      {:ok, account}
    else
      error -> error
    end
  end

  defp build(json) do
    %GatherContext.API.Account{
      id: json["id"] |> String.to_integer,
      name: json["name"],
      slug: json["slug"],
      timezone: json["timezone"]
    }
  end
end
