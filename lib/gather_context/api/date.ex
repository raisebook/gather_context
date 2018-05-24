defmodule GatherContext.API.Date do
  alias GatherContext.API.Date

  defstruct date: nil,
            timezone_type: nil,
            timezone: nil

  def build(json) do
    %Date{
      date: json["date"],
      timezone_type: json["timezone_type"],
      timezone: json["timezone"]
    }
  end
end

