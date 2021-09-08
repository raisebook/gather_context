defmodule GatherContext.Types.V2.ItemSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.V2.{Item, Structure, Group}
    alias GatherContext.Types.V2.Fields.{Guideline, Text}

    let(structure: nil)

    let(element: %Item{structure: structure()})

    subject(do: Item.encode(element()))

    describe "when structure" do
      describe "are not nil" do
        let(
          structure: %Structure{
            groups: [
              %Group{
                name: "Group",
                fields: [%Guideline{label: "Guideline"}, %Text{label: "Text"}]
              }
            ]
          }
        )

        it "encodes the structure" do
          expect(subject()[:structure])
          |> to(
            eq(%{
              groups: [
                %{
                  fields: [
                    %{label: "Guideline", type: "guideline"},
                    %{label: "Text", metadata: %{is_plain: false}, type: "text"}
                  ],
                  name: "Group"
                }
              ]
            })
          )
        end
      end

      describe "is nil" do
        let(structure: nil)

        it "omits the argument" do
          expect(subject() |> Map.has_key?(:structure)) |> to(eq(false))
        end
      end
    end
  end
end
