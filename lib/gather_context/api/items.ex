defmodule GatherContext.API.Item do
  use GatherContext.API.Base

  def all() do
    get("/items")
  end

  def fetch(id) do
    get("/items/#{id}")
  end

  def files(id) do
    get("/items/#{id}/files")
  end
end
