defmodule GatherContext.API.V2.Client do
  alias GatherContext.API.Client
  alias HTTPoison.{Response, Error}

  defstruct username: Application.fetch_env!(:gather_context, :username),
            api_key: Application.fetch_env!(:gather_context, :api_key),
            get: nil,
            post: nil

  @headers %{
    "Content-type" => "application/json",
    "Accept" => "application/vnd.gathercontent.v2+json"
  }

  def new(client = %Client{}) do
    client
  end

  def new() do
    new(%Client{})
  end

  def get(client, endpoint) do
    case HTTPoison.get(url(endpoint), @headers, options(client)) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, parse_data(body)}
      {:ok, %Response{status_code: 400, body: body}} -> {:error, parse_error(body)}
      {:ok, %Response{status_code: 401}} -> {:unauthorized}
      {:ok, %Response{status_code: 404}} -> {:not_found}
      {:error, %Error{reason: reason}} -> {:error, inspect(reason)}
      {:error, _} -> {:error, "Unknown error"}
    end
  end

  def post(client, endpoint, data) do
    case HTTPoison.post(url(endpoint), data, @headers, options(client)) do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, parse_data(body)}

      {:ok, %Response{status_code: 201}} ->
        {:ok}

      {:ok, %Response{status_code: 202, headers: headers}} ->
        {:ok, headers |> Map.new() |> Map.get("Location")}

      {:ok, %Response{status_code: 400, body: body}} ->
        {:error, parse_error(body)}

      {:ok, %Response{status_code: 401}} ->
        {:unauthorized}

      {:ok, %Response{status_code: 404}} ->
        {:not_found}

      {:error, %Error{reason: reason}} ->
        {:error, inspect(reason)}

      {:error, _} ->
        {:error, "Unknown error"}
    end
  end

  defp url(endpoint) do
    base = Application.fetch_env!(:gather_context, :api_host)
    port = Application.fetch_env!(:gather_context, :api_port)

    "#{base}:#{port}#{endpoint}"
  end

  defp parse(body) do
    body
    |> Poison.decode!()
  end

  defp parse_data(body) do
    parse(body)
    |> Access.get("data")
  end

  defp parse_error(body) do
    parse(body)
    |> Access.get("error")
  end

  defp options(%Client{username: username, api_key: api_key}) do
    [hackney: [basic_auth: {username, api_key}]]
  end
end
