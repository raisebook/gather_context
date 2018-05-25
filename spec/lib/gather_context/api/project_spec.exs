defmodule SharedProject do
  use ESpec, shared: true
  it "which has an id" do
    expect(shared.subject().id) |> to(eq(shared.id))
  end

  it "which has a name" do
    expect(shared.subject().name) |> to(eq(shared.name))
  end

  it "which has an account_id" do
    expect(shared.subject().account_id) |> to(eq(shared.account_id))
  end

  it "which has an active flag" do
    expect(shared.subject().active) |> to(eq(shared.active))
  end

  it "which has a text_direction" do
    expect(shared.subject().text_direction) |> to(eq(shared.text_direction))
  end

  it "which has an overdue flag" do
    expect(shared.subject().overdue) |> to(eq(shared.overdue))
  end

  it "which as a list of statuses" do
    expect(shared.subject().statuses |> length()) |> to(eq(shared.statuses |> length()))
  end
end

defmodule GatherContext.API.ProjectSpec do
  alias GatherContext.API.{Client, Project}
  alias GatherContext.Types

  use ESpec

  let :response_object, do: %{
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

  before subject: subject(),
          id: 123456,
          name: "Example Project",
          account_id: 123456,
          active: true,
          text_direction: "ltr",
          overdue: false,
          statuses: [%{
            id: 123456,
            is_default: true,
            position: 1,
            color: "#C5C5C5",
            name: "Draft",
            description: "",
            can_edit: true
          }, %{
            id: 123457,
            is_default: false,
            position: 2,
            color: "#FAA732",
            name: "Review",
            description: "",
            can_edit: true
          }]

  describe "all" do
    let :response, do: {:ok, [response_object()]}
    let :client, do: %Client{get: fn(_) -> response() end}
    subject do: (Project.all(client(), %Types.Account{id: 123456}) |> elem(1))

    it "returns a List" do
      expect(subject() |> length) |> to(eq(1))
    end

    describe "builds a List of %GatherContext.API.Project objects" do
      subject do: (Project.all(client(), %Types.Account{id: 123456}) |> elem(1) |> List.first)
      it_behaves_like(SharedProject)

      describe "statuses" do
        before subject: shared.statuses |> List.first,
                id: 123456,
                is_default: true,
                position: 1,
                color: "#C5C5C5",
                name: "Draft",
                description: "",
                can_edit: true

        it_behaves_like(SharedStatusSpec)
      end
    end
  end

  describe "get_account" do
    describe "when passing in a project" do
      let :response, do: {:ok, response_object()}
      let :client, do: %Client{get: fn(_) -> response() end}
      subject do: (Project.get_project(client(), %Project{id: 123456}) |> elem(1))

      describe "builds a %GatherContext.API.Account object" do
        subject do: (Project.get_project(client(), %Types.Project{id: 123456}) |> elem(1))
        it_behaves_like(SharedProject)

        describe "statuses" do
          before subject: shared.statuses |> List.first,
                  id: 123456,
                  is_default: true,
                  position: 1,
                  color: "#C5C5C5",
                  name: "Draft",
                  description: "",
                  can_edit: true

          it_behaves_like(SharedStatusSpec)
        end
      end
    end

    describe "when passing in project_id" do
      let :response, do: {:ok, response_object()}
      let :client, do: %Client{get: fn(_) -> response() end}
      subject do: (Project.get_project(client(), 123456) |> elem(1))

      describe "builds a %GatherContext.API.Account object" do
        subject do: (Project.get_project(client(), 123456) |> elem(1))
        it_behaves_like(SharedProject)

        describe "statuses" do
          before subject: shared.statuses |> List.first,
                  id: 123456,
                  is_default: true,
                  position: 1,
                  color: "#C5C5C5",
                  name: "Draft",
                  description: "",
                  can_edit: true

          it_behaves_like(SharedStatusSpec)
        end
      end
    end
  end
end
