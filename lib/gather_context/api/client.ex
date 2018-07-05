defmodule GatherContext.API.Client do
  @moduledoc """
    The Client module handles authentication, and is passed between modules to perform HTTP requests

    Example
      iex> client = %GatherContext.API.Client{username: "andrew@gathercontent.com", api_key: "00000000-0000-0000-0000-000000000000"}
      %GatherContext.API.Client{api_key: "00000000-0000-0000-0000-000000000000", username: "andrew@gathercontent.com"}
      iex> client |> GatherContext.API.Me.get
      {:ok, %GatherContext.API.Me{email: "andrew@gathercontent.com", first_name: "Andrew", last_name: "Cairns", timezone: "UTC", language: nil, gender: nil, avatar: "http://image-url.com"}
  """

  alias GatherContext.API.Client
  alias HTTPoison.Response

  defstruct username: Application.fetch_env!(:gather_context, :username),
            api_key: Application.fetch_env!(:gather_context, :api_key)
  @type t :: %__MODULE__{
    username: String.t,
    api_key: String.t
  }

  @headers %{"Content-type" => "application/json", "Accept" => "application/vnd.gathercontent.v0.5+json"}

  @doc """
    Creates a new Client struct filled with the supplied client details

    Example
      iex> GatherContext.API.Client.new(username: "andrew@gathercontent.com", api_key: "00000000-0000-0000-0000-000000000000")
      %GatherContext.API.Client{api_key: "00000000-0000-0000-0000-000000000000", get: nil, post: nil, username: "andrew@gathercontent.com"}
  """
  @spec new([username: String.t, api_key: String.t]) :: GatherContext.API.Client.t
  def new([username: username, api_key: api_key]) do
    %Client{username: username, api_key: api_key}
  end

  @doc """
    Creates a new Client struct filled with default client details (Pulled from the apps's config)

    Example
      iex> GatherContext.API.Client.new()
      %GatherContext.API.Client{api_key: "00000000-0000-0000-0000-000000000000", get: nil, post: nil, username: "andrew@gathercontent.com"}
  """
  @spec new() :: GatherContext.API.Client.t
  def new() do
    %Client{}
  end

  @doc false
  def get(client, endpoint) do
    case HTTPoison.get(url(endpoint), @headers, options(client)) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, parse_data(body)}
      {:ok, %Response{status_code: 400, body: body}} -> {:error, parse_error(body)}
      {:ok, %Response{status_code: 401}} -> {:unauthorized}
      {:ok, %Response{status_code: 404}} -> {:not_found}
    end
  end

  @doc false
  def post(client, endpoint, data) do
    case HTTPoison.post(url(endpoint), data, @headers, options(client)) do
      {:ok, %Response{status_code: 200}} -> {:ok}
      {:ok, %Response{status_code: 201}} -> {:ok}
      {:ok, %Response{status_code: 400, body: body}} -> {:error, parse_error(body)}
      {:ok, %Response{status_code: 401}} -> {:unauthorized}
      {:ok, %Response{status_code: 404}} -> {:not_found}
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

  defp options(%Client{username: username, api_key: api_key}) do
    [hackney: [basic_auth: {username, api_key}]]
  end
end
