defmodule GatherContext.Types.V2.Fields.TextSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.V2.Fields.Text
    alias GatherContext.Types.V2.Fields.Text.Metadata
    alias GatherContext.Types.V2.Fields.Text.Metadata.Validation
    alias GatherContext.Types.V2.Fields.Text.Metadata.Repeatable

    let(uuid: "00000000-0000-0000-0000-000000000000")
    let(label: "Label")
    let(instructions: "<p>Instructions</p>")
    let(validation: %Validation{})
    let(metadata: %Metadata{is_plain: false, validation: validation()})

    let(
      element: %Text{
        uuid: uuid(),
        label: label(),
        instructions: instructions(),
        metadata: metadata()
      }
    )

    subject(do: Text.encode(element()))

    it "encodes type" do
      expect(subject()[:type]) |> to(eq("text"))
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

    describe "metadata" do
      describe "is nil" do
        let(metadata: nil)

        it "sets the default" do
          expect(subject()[:metadata][:is_plain]) |> to(eq(false))
          expect(subject()[:metadata] |> Map.has_key?(:validation)) |> to(eq(false))
        end
      end

      describe "when validation" do
        describe "is nil" do
          let(metadata: %Metadata{validation: nil})

          it "omits the attribute" do
            expect(subject()[:metadata] |> Map.has_key?(:validation)) |> to(eq(false))
          end
        end

        describe "it not nil" do
          let(metadata: %Metadata{validation: %Validation{rule: "chars", limit: 10}})

          it "encodes the attribute" do
            expect(subject()[:metadata][:validation][:rule]) |> to(eq("chars"))
            expect(subject()[:metadata][:validation][:limit]) |> to(eq(10))
          end
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
      let(element: %Text{label: label()})

      it "omits uuid" do
        expect(subject() |> Map.has_key?(:uuid)) |> to(eq(false))
      end

      it "omits instructions" do
        expect(subject() |> Map.has_key?(:instructions)) |> to(eq(false))
      end

      describe "metadata" do
        it "sets is_plain to false" do
          expect(subject()[:metadata][:is_plain]) |> to(eq(false))
        end

        it "omits validation" do
          expect(subject()[:metadata] |> Map.has_key?(:validation)) |> to(eq(false))
        end
      end
    end
  end
end
