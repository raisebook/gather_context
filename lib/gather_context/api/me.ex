defmodule GatherContext.API.Me do
  alias GatherContext.API.Me

  defstruct email: nil,
            first_name: nil,
            last_name: nil,
            timezone: nil,
            language: nil,
            gender: nil,
            avatar: nil

  def get(client) do
    case client.get.("/me") do
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
