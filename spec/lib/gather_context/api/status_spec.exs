defmodule GatherContext.API.StatusSpec do
  alias GatherContext.API.{Client, Status}
  alias GatherContext.Types.{Project}
  use ESpec

  let :obj, do: %{
    "id" => "123456",
    "is_default" => true,
    "position" => "1",
    "color" => "#C5C5C5",
    "name" => "Draft",
    "description" => "",
    "can_edit" => true
  }

  describe "all" do
    let :response, do: {:ok, [obj()]}
    let :client, do: %Client{get: fn(_) -> response() end}
    subject do: (Status.all(client(), %Project{id: 123456}) |> elem(1))

    it "returns a List" do
      expect(subject() |> length) |> to(eq(1))
    end

    describe "builds a List of %GatherContext.Types.Account objects" do
      subject do: (Status.all(client(), %Project{id: 123456}) |> elem(1) |> List.first)
      before subject: subject(),
              id: 123456,
              is_default: true,
              position: 1,
              color: "#C5C5C5",
              name: "Draft",
              description: "",
              can_edit: true

      it_behaves_like(SharedStatusSpec)
    end

    describe "get_account" do
      let :response, do: {:ok, obj()}
      let :client, do: %Client{get: fn(_) -> response() end}
      subject do: (Status.get_status(client(), %Project{id: 123456}, 123456) |> elem(1))

      describe "builds a %GatherContext.Types.Account object" do
        before subject: subject(),
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
