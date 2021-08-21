defmodule GatherContext.Types.V2.Fields.GuidelineSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.V2.Fields.Guideline

    let(uuid: "00000000-0000-0000-0000-000000000000")
    let(label: "Label")
    let(instructions: "<p>Instructions</p>")

    let(element: %Guideline{uuid: uuid(), label: label(), instructions: instructions()})

    subject(do: Guideline.encode(element()))

    it "encodes type" do
      expect(subject()[:type]) |> to(eq("guideline"))
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

        it "omits the argument" do
          expect(subject() |> Map.has_key?(:instructions)) |> to(eq(false))
        end
      end
    end

    describe "a default object" do
      let(element: %Guideline{label: label()})

      it "omits uuid" do
        expect(subject() |> Map.has_key?(:uuid)) |> to(eq(false))
      end

      it "omits instructions" do
        expect(subject() |> Map.has_key?(:instructions)) |> to(eq(false))
      end
    end
  end
end
