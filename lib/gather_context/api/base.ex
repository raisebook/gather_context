defmodule GatherContext.API.Base do
  defmacro __using__(_opts) do
    quote do
      import GatherContext.API.Base
      @before_compile GatherContext.API.Base
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      @headers %{"Content-type" => "application/json", "Accept" => "application/vnd.gathercontent.v0.5+json"}

      def get(endpoint) do
        case HTTPoison.get(url(endpoint), @headers, options()) do
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

      defp options() do
        user = Application.fetch_env!(:gather_context, :username)
        api_key = Application.fetch_env!(:gather_context, :api_key)
        [hackney: [basic_auth: {user, api_key}]]
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
  end
end
