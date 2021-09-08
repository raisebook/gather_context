defmodule GatherContext.Types.V2.StructureSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.V2.{Structure, Group}
    alias GatherContext.Types.V2.Fields.{Guideline, Text}

    let(uuid: "00000000-0000-0000-0000-000000000000")
    let(groups: [])

    let(element: %Structure{uuid: uuid(), groups: groups()})

    subject(do: Structure.encode(element()))

    describe "when uuid" do
      describe "is not nil" do
        let(uuid: "00000000-0000-0000-0000-000000000000")

        it "encodes the uuid" do
          expect(subject()[:uuid]) |> to(eq(uuid()))
        end
      end

      describe "is nil" do
        let(uuid: nil)

        it "omits the argument" do
          expect(subject() |> Map.has_key?(:uuid)) |> to(eq(false))
        end
      end
    end

    describe "when groups" do
      describe "are not nil" do
        let(
          groups: [
            %Group{
              uuid: uuid(),
              name: "Group",
              fields: [%Guideline{label: "Guideline"}, %Text{label: "Text"}]
            }
          ]
        )

        it "encodes the groups" do
          expect(subject()[:groups])
          |> to(
            eq([
              %{
                fields: [
                  %{label: "Guideline", type: "guideline"},
                  %{label: "Text", metadata: %{is_plain: false}, type: "text"}
                ],
                name: "Group",
                uuid: "00000000-0000-0000-0000-000000000000"
              }
            ])
          )
        end
      end

      describe "are nil" do
        let(groups: nil)

        it "raises an ArgumentError" do
          expect(fn -> subject() end) |> to(raise_exception(ArgumentError))
        end
      end
    end
  end
end
