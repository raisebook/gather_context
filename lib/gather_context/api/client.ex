defmodule GatherContext.API.Client do
  alias GatherContext.API.Client
  defstruct username: Application.fetch_env!(:gather_context, :username),
            api_key: Application.fetch_env!(:gather_context, :api_key),
            get: nil

  @headers %{"Content-type" => "application/json", "Accept" => "application/vnd.gathercontent.v0.5+json"}

  def new(client = %Client{}) do
    options = [hackney: [basic_auth: {client.username, client.api_key}]]
    client |> Map.merge(%Client{get: fn(url) -> Client.get(url, options) end})
  end

  def new() do
    new(%Client{})
  end

  def get(endpoint, options) do
    case HTTPoison.get(url(endpoint), @headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, parse_data(body)}
      {:ok, %HTTPoison.Response{status_code: 400, body: body}} -> {:error, parse_error(body)}
      {:ok, %HTTPoison.Response{status_code: 401}} -> {:unauthorized}
      {:ok, %HTTPoison.Response{status_code: 404}} -> {:not_found}
    end
  end

  defp url(endpoint)  do
    base = Application.fetch_env!(:gather_context, :api_host)
    port = Application.fetch_env!(:gather_context, :api_port)

    "#{base}:#{port}/#{endpoint}"
  end

  defp parse(body) do
    body
    |> Poison.decode!
  end

  defp parse_data(body) do
    parse(body)
    |> Access.get("data")
  end

  defp parse_error(body) do
    parse(body)
    |> Access.get("error")
  end
end
