defmodule SharedItems do
  use ESpec, shared: true

  it "which has an id" do
    expect(shared.subject().id) |> to(eq(shared.id))
  end

  it "which has a project id" do
    expect(shared.subject().project_id) |> to(eq(shared.project_id))
  end

  it "which has a parent id" do
    expect(shared.subject().parent_id) |> to(eq(shared.parent_id))
  end

  it "which has a template id" do
    expect(shared.subject().template_id) |> to(eq(shared.template_id))
  end

  it "which has a position" do
    expect(shared.subject().position) |> to(eq(shared.position))
  end

  it "which has a name" do
    expect(shared.subject().name) |> to(eq(shared.name))
  end

  it "which has notes" do
    expect(shared.subject().notes) |> to(eq(shared.notes))
  end

  it "which has a type" do
    expect(shared.subject().type) |> to(eq(shared.type))
  end

  it "which has an overdue flag" do
    expect(shared.subject().overdue) |> to(eq(shared.overdue))
  end

  it "which has a created at date" do
    expect(shared.subject().created_at) |> to(eq(shared.created_at))
  end

  it "which has an updated at date" do
    expect(shared.subject().updated_at) |> to(eq(shared.updated_at))
  end

  it "which has a status" do
    expect(shared.subject().status) |> to(eq(shared.status))
  end

  it "which has due_dates" do
    expect(shared.subject().due_dates) |> to(eq(shared.due_dates))
  end
end

defmodule SharedItem do
  use ESpec, shared: true

  it "which has an id" do
    expect(shared.subject().id) |> to(eq(shared.id))
  end

  it "which has a project id" do
    expect(shared.subject().project_id) |> to(eq(shared.project_id))
  end

  it "which has a parent id" do
    expect(shared.subject().parent_id) |> to(eq(shared.parent_id))
  end

  it "which has a template id" do
    expect(shared.subject().template_id) |> to(eq(shared.template_id))
  end

  it "which has a position" do
    expect(shared.subject().position) |> to(eq(shared.position))
  end

  it "which has a name" do
    expect(shared.subject().name) |> to(eq(shared.name))
  end

  it "which has a config" do
    expect(shared.subject().config) |> to(eq(shared.config))
  end

  it "which has notes" do
    expect(shared.subject().notes) |> to(eq(shared.notes))
  end

  it "which has a type" do
    expect(shared.subject().type) |> to(eq(shared.type))
  end

  it "which has an overdue flag" do
    expect(shared.subject().overdue) |> to(eq(shared.overdue))
  end

  it "which has a created at date" do
    expect(shared.subject().created_at) |> to(eq(shared.created_at))
  end

  it "which has an updated at date" do
    expect(shared.subject().updated_at) |> to(eq(shared.updated_at))
  end

  it "which has a status" do
    expect(shared.subject().status) |> to(eq(shared.status))
  end

  it "which has due_dates" do
    expect(shared.subject().due_dates) |> to(eq(shared.due_dates))
  end
end

defmodule GatherContext.API.ItemSpec do
  use ESpec
  alias GatherContext.API.{Client, Item}
  alias GatherContext.Types.{Config, Status, Date, DueDate, Project}

  let client: %Client{}
  before do: allow(Client).to accept(:get, fn(%Client{}, _) -> response() end)

  describe "all" do
    subject do: (Item.all(client(), %Project{id: 123456}) |> elem(1))

    let :obj, do: %{
      "id" => 123456,
      "project_id" => 123456,
      "parent_id" => 0,
      "template_id" => nil,
      "position" => "11",
      "name" => "Home",
      "notes" => "",
      "type" => "item",
      "overdue" => true,
      "created_at" => %{
          "date" => "2015-07-31 10:58:12.000000",
          "timezone_type"  => 3,
          "timezone"  => "UTC"
      },
      "updated_at"  => %{
          "date" => "2015-07-31 10:58:12.000000",
          "timezone_type" => 3,
          "timezone" => "UTC"
      },
      "status" => %{
          "data" => %{
              "id" => "123456",
              "is_default" => true,
              "position" => "1",
              "color" => "#C5C5C5",
              "name" => "Draft",
              "description" => "",
              "can_edit" => true
          }
      },
      "due_dates" => %{
          "data" => [
              %{
                  "status_id" => 123456,
                  "overdue" => true,
                  "due_date" => %{
                      "date" => "2015-07-02 12:00:00.000000",
                      "timezone_type" => 3,
                      "timezone" => "UTC"
                  }
              },
              %{
                  "status_id" => 123457,
                  "overdue" => true,
                  "due_date" => %{
                      "date" => "2015-07-03 16:00:00.000000",
                      "timezone_type" => 3,
                      "timezone" => "UTC"
                  }
              }
          ]
      }
    }

    let :response, do: {:ok, [obj()]}

    before subject: subject(),
            id: 123456,
            project_id: 123456,
            parent_id: 0,
            template_id: nil,
            position: 11,
            name: "Home",
            notes: "",
            type: "item",
            overdue: true,
            created_at: %Date{date: "2015-07-31 10:58:12.000000", timezone_type: 3, timezone: "UTC"},
            updated_at: %Date{date: "2015-07-31 10:58:12.000000", timezone_type: 3, timezone: "UTC"},
            status: %Status{id: 123456, is_default: true, position: 1, color: "#C5C5C5", name: "Draft", description: "", can_edit: true},
            due_dates: [
              %DueDate{
                status_id: 123456,
                overdue: true,
                due_date: %Date{date: "2015-07-02 12:00:00.000000", timezone_type: 3, timezone: "UTC"},
              },
              %DueDate{
                status_id: 123457,
                overdue: true,
                due_date: %Date{date: "2015-07-03 16:00:00.000000", timezone_type: 3, timezone: "UTC"},
              }
            ]

    it "returns a List" do
      expect(subject() |> length) |> to(eq(1))
    end

    describe "builds a List of %GatherContext.API.Account objects" do
      describe "with a %Project{} as a parameter" do
        subject do: (Item.all(client(), %Project{id: 123456}) |> elem(1) |> List.first)
        it_behaves_like(SharedItems)
      end

      describe "with a integer as a parameter" do
        subject do: (Item.all(client(), 123456) |> elem(1) |> List.first)
        it_behaves_like(SharedItems)
      end
    end
  end

  describe "get_item" do
    let :response, do: {:ok, obj()}
    subject do: (Item.get_item(client(), 123456) |> elem(1))

    let :obj, do: %{
      "id" => 123456,
      "project_id" => 123456,
      "parent_id" => 0,
      "template_id" => nil,
      "position" => "11",
      "name" => "Home",
      "notes" => "",
      "config" => [],
      "type" => "item",
      "overdue" => true,
      "created_at" => %{
          "date" => "2015-07-31 10:58:12.000000",
          "timezone_type"  => 3,
          "timezone"  => "UTC"
      },
      "updated_at"  => %{
          "date" => "2015-07-31 10:58:12.000000",
          "timezone_type" => 3,
          "timezone" => "UTC"
      },
      "status" => %{
          "data" => %{
              "id" => "123456",
              "is_default" => true,
              "position" => "1",
              "color" => "#C5C5C5",
              "name" => "Draft",
              "description" => "",
              "can_edit" => true
          }
      },
      "due_dates" => %{
          "data" => [
              %{
                  "status_id" => 123456,
                  "overdue" => true,
                  "due_date" => %{
                      "date" => "2015-07-02 12:00:00.000000",
                      "timezone_type" => 3,
                      "timezone" => "UTC"
                  }
              },
              %{
                  "status_id" => 123457,
                  "overdue" => true,
                  "due_date" => %{
                      "date" => "2015-07-03 16:00:00.000000",
                      "timezone_type" => 3,
                      "timezone" => "UTC"
                  }
              }
          ]
      }
    }

    before subject: subject(),
            id: 123456,
            project_id: 123456,
            parent_id: 0,
            template_id: nil,
            position: 11,
            name: "Home",
            config: %Config{},
            notes: "",
            type: "item",
            overdue: true,
            created_at: %Date{date: "2015-07-31 10:58:12.000000", timezone_type: 3, timezone: "UTC"},
            updated_at: %Date{date: "2015-07-31 10:58:12.000000", timezone_type: 3, timezone: "UTC"},
            status: %Status{id: 123456, is_default: true, position: 1, color: "#C5C5C5", name: "Draft", description: "", can_edit: true},
            due_dates: [
              %DueDate{
                status_id: 123456,
                overdue: true,
                due_date: %Date{date: "2015-07-02 12:00:00.000000", timezone_type: 3, timezone: "UTC"},
              },
              %DueDate{
                status_id: 123457,
                overdue: true,
                due_date: %Date{date: "2015-07-03 16:00:00.000000", timezone_type: 3, timezone: "UTC"},
              }
            ]

    describe "builds a %GatherContext.Types.Item object" do
      describe "when passes an Item" do
        subject do: (Item.get_item(client(), %GatherContext.Types.Item{id: 123456}) |> elem(1))
        it_behaves_like(SharedItem)
      end

      describe "when passes an integer" do
        subject do: (Item.get_item(client(), 123456) |> elem(1))
        it_behaves_like(SharedItem)
      end
    end
  end

  describe "choose status" do
    before do: allow(Client).to accept(:post, fn(%Client{}, _, _) -> {:ok} end)

    describe "with item id as an integer, and status_id as an integer" do
      subject do: (Item.choose_status(client(), 123456, 123457))

      it "chooses the status" do
        subject()
        expect(Client) |> to(accepted(:post, [client(), "/items/123456/choose_status", "status_id=123457"]))
      end
    end

    describe "with a %Item{}, and %Status{}" do
      subject do: (Item.choose_status(client(), %GatherContext.Types.Item{id: 123456}, %GatherContext.Types.Status{id: 123457}))

      it "chooses the status" do
        subject()
        expect(Client) |> to(accepted(:post, [client(), "/items/123456/choose_status", "status_id=123457"]))
      end
    end

    describe "with a %Item{}, and status_id is an integer" do
      subject do: (Item.choose_status(client(), %GatherContext.Types.Item{id: 123456}, 123457))

      it "chooses the status" do
        subject()
        expect(Client) |> to(accepted(:post, [client(), "/items/123456/choose_status", "status_id=123457"]))
      end
    end

    describe "with a id is an integer, and %Status{}" do
      subject do: (Item.choose_status(client(), 123456, %GatherContext.Types.Status{id: 123457}))

      it "chooses the status" do
        subject()
        expect(Client) |> to(accepted(:post, [client(), "/items/123456/choose_status", "status_id=123457"]))
      end
    end
  end

  describe "apply_template" do
    before do: allow(Client).to accept(:post, fn(%Client{}, _, _) -> {:ok} end)

    describe "with item id as an integer" do
      subject do: (Item.apply_template(client(), 123456, 123457))

      it "applies the template'" do
        subject()
        expect(Client) |> to(accepted(:post, [client(), "/items/123456/apply_template", "template_id=123457"]))
      end
    end

    describe "with an %Item{}" do
      subject do: (Item.apply_template(client(), %GatherContext.Types.Item{id: 123456}, 123457))

      it "applies the template'" do
        subject()
        expect(Client) |> to(accepted(:post, [client(), "/items/123456/apply_template", "template_id=123457"]))
      end
    end
  end
end
