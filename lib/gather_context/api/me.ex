defmodule GatherContext.API.Me do
  @moduledoc """
    Get information about the logged in User
  """
  alias GatherContext.API.Client
  alias GatherContext.Types.Me

  @doc """
    Access to all fields of information about the logged in User such as their avatar url, name, and other fields.

    Example
      iex> client = %GatherContext.API.Client{username: "andrew@gathercontent.com", api_key: "00000000-0000-0000-0000-000000000000"}
      %GatherContext.API.Client{api_key: "00000000-0000-0000-0000-000000000000", username: "andrew@gathercontent.com"}
      iex> client |> GatherContext.API.Me.get
      {:ok, %GatherContext.API.Me{email: "andrew@gathercontent.com", first_name: "Andrew", last_name: "Cairns", timezone: "UTC", language: nil, gender: nil, avatar: "http://image-url.com"}
  """
  @spec get(GatherContext.API.Client.t) :: {:ok, GatherContext.Types.Me.t}
  @spec get(GatherContext.API.Client.t) :: {:error, String.t}
  @spec get(GatherContext.API.Client.t) :: {:unauthorized}
  def get(client) do
    case client |> Client.get("/me") do
      {:ok, me} -> {:ok, build(me)}
      error -> error
    end
  end

  defp build(json) do
    %Me{
      email: json["email"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      timezone: json["timezone"],
      language: json["language"],
      gender: json["gender"],
      avatar: json["avatar"]
    }
  end
end
