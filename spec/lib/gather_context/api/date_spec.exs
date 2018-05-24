defmodule GatherContext.API.DateSpec do
  use ESpec
  alias GatherContext.API.Date

  let obj: %{
    "date" => "2015-07-31 10:58:12.000000",
    "timezone_type" => 3,
    "timezone" => "UTC"
  }

  describe "build" do
    subject do: (Date.build(obj()))

    it "has a date string" do
      expect(subject().date) |> to(eq("2015-07-31 10:58:12.000000"))
    end

    it "has an timezone_type" do
      expect(subject().timezone_type) |> to(eq(3))
    end

    it "has a timezone" do
      expect(subject().timezone) |> to(eq("UTC"))
    end
  end
end
