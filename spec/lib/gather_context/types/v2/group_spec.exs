defmodule GatherContext.Types.V2.GroupSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.V2.Group
    alias GatherContext.Types.V2.Fields.{Guideline, Text}

    let(uuid: "00000000-0000-0000-0000-000000000000")
    let(name: "Name")
    let(fields: [])

    let(element: %Group{uuid: uuid(), name: name(), fields: fields()})

    subject(do: Group.encode(element()))

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

    describe "when name" do
      describe "is not nil" do
        let(name: "Name")

        it "encodes the name" do
          expect(subject()[:name]) |> to(eq(name()))
        end
      end

      describe "is nil" do
        let(name: nil)

        it "raises an ArgumentError" do
          expect(fn -> subject() end) |> to(raise_exception(ArgumentError))
        end
      end
    end

    describe "when fields" do
      describe "are not nil" do
        let(fields: [%Guideline{label: "Guideline"}, %Text{label: "Text"}])

        it "encodes the fields" do
          expect(subject()[:fields])
          |> to(
            eq([
              %{label: "Guideline", type: "guideline"},
              %{label: "Text", metadata: %{is_plain: false}, type: "text"}
            ])
          )
        end
      end

      describe "are nil" do
        let(fields: nil)

        it "raises an ArgumentError" do
          expect(fn -> subject() end) |> to(raise_exception(ArgumentError))
        end
      end
    end
  end
end
