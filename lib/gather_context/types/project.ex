defmodule GatherContext.Types.Project do
  @typedoc """
    Represents a GatherContent Project

    Example
    -------
      %GatherContext.Types.Project{
        id: 123456,
        name: "Example Project",
        account_id: 123456,
        active: true,
        text_direction: "rtl",
        overdue: false,
        statuses: [
          %GatherContext.Types.Status{
            id: "123456",
            is_default: true,
            position: "1",
            color: "#C5C5C5",
            name: "Draft",
            description: "",
            can_edit: true
          },
          %GatherContext.Types.Status{
            id: "123457",
            is_default: false,
            position: "2",
            color: "#FAA732",
            name: "Review",
            description: "",
            can_edit: true
          },
          %GatherContext.Types.Status{
            id: "123458",
            is_default: false,
            position: "3",
            color: "#5EB95E",
            name: "Final edits",
            description: "",
            can_edit: true
          },
          %GatherContext.Types.Status{
            id: "123459",
            is_default: false,
            position: "4",
            color: "#DD4398",
            name: "Ready to be published",
            description: "",
            can_edit: false
          }
        }
      }
  """
  @type t :: %__MODULE__{
    id: integer(),
    name: binary(),
    account_id: integer(),
    active: boolean(),
    text_direction: binary(),
    overdue: boolean(),
    statuses: list(GatherContext.Types.Status.t)
  }
  defstruct id: nil,
            name: nil,
            account_id: nil,
            active: false,
            text_direction: nil,
            overdue: nil,
            statuses: []
end
