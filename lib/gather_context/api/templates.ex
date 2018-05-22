defmodule GatherContext.API.Accounts do
  use GatherContext.API.Base

  def all() do
    get("/templates")
  end

  def fetch(id) do
    get("/templates/#{id}")
  end
end
