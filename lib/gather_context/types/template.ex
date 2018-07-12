defmodule GatherContext.Types.Template do
  @typedoc """
    Represents an GatherContent Template

    Example
    -------
    %GatherContext.Types.Template{
      id: 123456,
      project_id: 123456,
      created_by: 123456,
      updated_by: 123456,
      name: "Blog Theme",
      description: "Blog theme",
      config: %GatherContext.Types.Config{},
      used_at: "2015-08-26 17:03:20",
      created_at: 1440604320,
      updated_at: 1440608600,
      usage: %GatherContext.Types.TemplateUsage{
        item_count: 1
      }
  """
  @type t :: %__MODULE__{
    id: integer(),
    project_id: integer(),
    created_by: binary(),
    updated_by: binary(),
    name: binary(),
    description: binary(),
    config: GatherContext.Types.Config.t,
    used_at: binary(),
    created_at: integer(),
    updated_at: integer(),
    usage: GatherContext.Types.TemplateUsage.t
  }
  defstruct id: nil,
            project_id: nil,
            created_by: false,
            updated_by: nil,
            name: nil,
            description: nil,
            config: nil,
            used_at: nil,
            created_at: nil,
            updated_at: nil,
            usage: nil
end
