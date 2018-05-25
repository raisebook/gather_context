defmodule GatherContext.API.Date do
  alias GatherContext.Types.Date

  def build(json) do
    %Date{
      date: json["date"],
      timezone_type: json["timezone_type"],
      timezone: json["timezone"]
    }
  end
end

