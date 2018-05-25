defmodule GatherContext.API.Me do
  alias GatherContext.API.Client
  alias GatherContext.Types.Me

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
