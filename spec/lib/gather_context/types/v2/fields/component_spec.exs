defmodule GatherContext.Types.V2.Fields.ComponentSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.V2.Fields.Component
    alias GatherContext.Types.V2.Fields.Component.Metadata
    alias GatherContext.Types.V2.Fields.Component.Metadata.Repeatable
    alias GatherContext.Types.V2.Structure

    let(uuid: "00000000-0000-0000-0000-000000000000")
    let(label: "Label")
    let(instructions: "<p>Instructions</p>")
    let(component: nil)
    let(structure: nil)
    let(metadata: nil)

    let(
      element: %Component{
        uuid: uuid(),
        label: label(),
        instructions: instructions(),
        component: component(),
        structure: structure(),
        metadata: metadata()
      }
    )

    subject(do: Component.encode(element()))

    it "encodes type" do
      expect(subject()[:type]) |> to(eq("component"))
    end

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

    describe "when label" do
      describe "is not nil" do
        let(label: "Label")

        it "encodes the label" do
          expect(subject()[:label]) |> to(eq(label()))
        end
      end

      describe "is nil" do
        let(label: nil)

        it "raises an ArgumentError" do
          expect(fn -> subject() end) |> to(raise_exception(ArgumentError))
        end
      end

      describe "is empty" do
        let(label: "")

        it "raises an ArgumentError" do
          expect(fn -> subject() end) |> to(raise_exception(ArgumentError))
        end
      end
    end

    describe "when instructions" do
      describe "is not nil" do
        let(instructions: "<p>Instructions</p>")

        it "encodes the instructions" do
          expect(subject()[:instructions]) |> to(eq(instructions()))
        end
      end

      describe "is nil" do
        let(instructions: nil)

        it "omits the attribute" do
          expect(subject() |> Map.has_key?(:instructions)) |> to(eq(false))
        end
      end
    end

    describe "when structure" do
      describe "is not nil" do
        let(structure: %Structure{uuid: "00000000-0000-0000-000000000000"})

        it "encodes the structure" do
          expect(subject()[:structure])
          |> to(eq(%{uuid: "00000000-0000-0000-000000000000", groups: []}))
        end
      end

      describe "is nil" do
        let(structure: nil)

        it "omits the attribute" do
          expect(subject() |> Map.has_key?(:structure)) |> to(eq(false))
        end
      end
    end

    describe "when component" do
      describe "is not nil" do
        let(component: "00000000-0000-0000-000000000000")

        it "encodes the component uuid" do
          expect(subject()[:component]) |> to(eq("00000000-0000-0000-000000000000"))
        end
      end

      describe "is nil" do
        let(component: nil)

        it "omits the attribute" do
          expect(subject() |> Map.has_key?(:component)) |> to(eq(false))
        end
      end
    end

    describe "metadata" do
      describe "is nil" do
        let(metadata: nil)

        it "omits the attribute" do
          expect(subject() |> Map.has_key?(:metadata)) |> to(eq(false))
        end
      end

      describe "when repeatable" do
        describe "is nil" do
          let(metadata: %Metadata{repeatable: nil})

          it "omits the attribute" do
            expect(subject()[:metadata] |> Map.has_key?(:repeatable)) |> to(eq(false))
          end
        end

        describe "it not nil" do
          let(
            metadata: %Metadata{
              repeatable: %Repeatable{is_repeatable: true, limit_enabled: true, limit: 10}
            }
          )

          it "encodes the attribute" do
            expect(subject()[:metadata][:repeatable][:is_repeatable]) |> to(eq(true))
            expect(subject()[:metadata][:repeatable][:limit_enabled]) |> to(eq(true))
            expect(subject()[:metadata][:repeatable][:limit]) |> to(eq(10))
          end
        end
      end
    end

    describe "a default object" do
      let(element: %Component{label: label()})

      it "omits uuid" do
        expect(subject() |> Map.has_key?(:uuid)) |> to(eq(false))
      end

      it "omits instructions" do
        expect(subject() |> Map.has_key?(:instructions)) |> to(eq(false))
      end

      it "omits structure" do
        expect(subject() |> Map.has_key?(:structure)) |> to(eq(false))
      end

      it "omits component" do
        expect(subject() |> Map.has_key?(:component)) |> to(eq(false))
      end

      it "omits metadata" do
        expect(subject() |> Map.has_key?(:metadata)) |> to(eq(false))
      end
    end
  end
end
