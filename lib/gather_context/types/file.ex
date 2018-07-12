defmodule GatherContext.Types.File do
  @typedoc """
    Represents an GatherContent File

    Example
    -------
      %GatherContext.Types.File{
        id: 1,
        user_id: 1,
        item_id: 1,
        field: "abc123",
        type: "1",
        url: "http://link.to/filename.png",
        filename: "original.png",
        size: 123456,
        created_at: "2015-12-10 18:49:17",
        updated_at: "2015-12-10 18:49:17"
      }
  """
  @type t :: %__MODULE__{
    id: integer(),
    user_id: integer(),
    item_id: integer(),
    field: binary(),
    type: binary(),
    url: binary(),
    filename: binary(),
    size: integer(),
    created_at: binary(),
    updated_at: binary()
  }
  defstruct id: nil,
            user_id: nil,
            item_id: nil,
            field: nil,
            type: nil,
            url: nil,
            filename: nil,
            size: nil,
            created_at: nil,
            updated_at: nil
end
