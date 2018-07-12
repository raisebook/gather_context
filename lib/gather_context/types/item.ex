defmodule GatherContext.Types.Item do
  alias GatherContext.Types.{Config, Date, DueDate, Status}

   @typedoc """
    Represents an GatherContent Item

    Example
    -------
      %GatherContext.Types.Item{
        id: 123456,
        project_id: 123456,
        parent_id: 0,
        template_id: null,
        position: 11,
        name: "Home",
        config: [],
        notes: "",
        type: "item",
        overdue: true,
        updated_at: %GatherContext.Types.Date{
            date: "2015-08-26 15:16:02.000000",
            timezone_type: 3,
            timezone: "UTC"
        },
        created_at: %GatherContext.Types.Date{
            date: "2015-08-26 15:16:02.000000",
            timezone_type: 3,
            timezone: "UTC"
        },
        status: %GatherContext.Types.Status{
            id: "123456",
            is_default: true,
            position: 1,
            color: "#C5C5C5",
            name: "Draft",
            description: "",
            can_edit: true
        },
        due_dates: []
      }
  """
  @type t :: %__MODULE__{
    id: integer(),
    project_id: integer(),
    parent_id: integer(),
    template_id: integer(),
    position: integer(),
    name: binary(),
    config: GatherContext.Types.Config.t,
    notes: binary(),
    type: binary(),
    overdue: boolean(),
    created_at: GatherContext.Types.Date.t,
    updated_at: GatherContext.Types.Date.t,
    status: GatherContext.Types.Status.t,
    due_dates: GatherContext.TypesDueDate.t
  }
  defstruct id: nil,
            project_id: nil,
            parent_id: nil,
            template_id: nil,
            position: 0,
            name: nil,
            config: %Config{},
            notes: nil,
            type: "item",
            overdue: false,
            created_at: %Date{},
            updated_at: %Date{},
            status: %Status{},
            due_dates: %DueDate{}
end
