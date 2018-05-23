defmodule GatherContext.API.ProjectSpec do
  alias GatherContext.API.{Project,Account, Status}

  use ESpec

  let :obj, do: %{
    "id" => 123456,
    "name" => "Example Project",
    "account_id" => 123456,
    "active" => true,
    "text_direction" => "ltr",
    "overdue" => false,
    "statuses" => %{
      "data" => [
        %{
          "id" => "123456",
          "is_default" => true,
          "position" => "1",
          "color" => "#C5C5C5",
          "name" => "Draft",
          "description" => "",
          "can_edit" => true
        },
        %{
          "id" => "123457",
          "is_default" => false,
          "position" => "2",
          "color" => "#FAA732",
          "name" => "Review",
          "description" => "",
          "can_edit" => true
        }
      ]
    }
  }

  describe "all" do
    let :response, do: {:ok, [obj()]}
    let :client, do: %GatherContext.API.Client{get: fn(_) -> response() end}
    subject do: (GatherContext.API.Project.all(client(), %Account{id: 123456}) |> elem(1))

    it "returns a List" do
      expect(subject() |> length) |> to(eq(1))
    end

    describe "builds a List of %GatherContext.API.Project objects" do
      subject do: (GatherContext.API.Project.all(client(), %Account{id: 123456}) |> elem(1) |> List.first)

      it "which has an id" do
        expect(subject().id) |> to(eq(123456))
      end

      it "which has a name" do
        expect(subject().name) |> to(eq("Example Project"))
      end

      it "which has an account_id" do
        expect(subject().account_id) |> to(eq(123456))
      end

      it "which has an active flag" do
        expect(subject().active) |> to(eq(true))
      end

      it "which has a text_direction" do
        expect(subject().text_direction) |> to(eq("ltr"))
      end

      it "which has an overdue flag" do
        expect(subject().overdue) |> to(eq(false))
      end

      it "which as a list of statuses" do
        expect(subject().statuses |> length()) |> to(eq(2))
      end
    end
  end

  describe "get_account" do
    let :response, do: {:ok, obj()}
    let :client, do: %GatherContext.API.Client{get: fn(_) -> response() end}
    subject do: (GatherContext.API.Project.get_project(client(), 123456) |> elem(1))

    describe "builds a %GatherContext.API.Account object" do
      subject do: (GatherContext.API.Project.get_project(client(), 123456) |> elem(1))

      it "which has an id" do
        expect(subject().id) |> to(eq(123456))
      end

      it "which has a name" do
        expect(subject().name) |> to(eq("Example Project"))
      end

      it "which has an account_id" do
        expect(subject().account_id) |> to(eq(123456))
      end

      it "which has an active flag" do
        expect(subject().active) |> to(eq(true))
      end

      it "which has a text_direction" do
        expect(subject().text_direction) |> to(eq("ltr"))
      end

      it "which has an overdue flag" do
        expect(subject().overdue) |> to(eq(false))
      end

      it "which as a list of statuses" do
        expect(subject().statuses |> length()) |> to(eq(2))
      end
    end
  end
end
