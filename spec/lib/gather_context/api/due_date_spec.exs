defmodule GatherContext.API.DueDateSpec do
  use ESpec
  alias GatherContext.API.{Date, DueDate}

  let obj: %{
    "status_id" => 123456,
    "overdue" => true,
    "due_date" => %{
      "date" => "2015-07-02 12:00:00.000000",
      "timezone_type" => 3,
      "timezone" => "UTC"
    }
  }

  describe "build" do
    subject do: (DueDate.build(obj()))

    it "has a status_id" do
      expect(subject().status_id) |> to(eq(123456))
    end

    it "has an timezone_type" do
      expect(subject().overdue) |> to(eq(true))
    end

    it "has a due date" do
      expect(subject().due_date) |> to(eq(%Date{date: "2015-07-02 12:00:00.000000", timezone_type: 3, timezone: "UTC"}))
    end
  end
end
