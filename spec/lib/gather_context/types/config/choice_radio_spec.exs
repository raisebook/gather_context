defmodule GatherContext.Types.Config.ChoiceRadioSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.Config.{ChoiceRadio,Option}

    let name: "el4"
    let required: true
    let label: "Label"
    let microcopy: "Select something"
    let other_option: false
    let option: %Option{name: "op1", label: "Option 1", selected: false}
    let options: [option()]

    let element: %ChoiceRadio{name: name(), required: required(), label: label(), microcopy: microcopy(), other_option: other_option(), options: options()}

    subject do: ChoiceRadio.encode(element())

    it "encodes type" do
      expect(subject()[:type]) |> to(eq("choice_radio"))
    end

    describe "when name" do
      describe "is not empty" do
        let name: "el4"

        it "encodes the name" do
          expect(subject()[:name]) |> to(eq(name()))
        end
      end

      describe "is empty" do
        let name: ""

        it "raises an ArgumentError" do
          expect(fn -> subject() end) |> to(raise_exception ArgumentError)
        end
      end
    end

    describe "when label" do
      describe "is not empty" do
        let label: "Label"

        it "encodes the label" do
          expect(subject()[:label]) |> to(eq(label()))
        end
      end

      describe "is empty" do
        let label: ""

        it "raises an ArgumentError" do
           expect(fn -> subject() end) |> to(raise_exception ArgumentError)
        end
      end
    end

    it "encodes required" do
      expect(subject()[:required]) |> to(eq(required()))
    end

    it "encodes microcopy" do
      expect(subject()[:microcopy]) |> to(eq(microcopy()))
    end

    describe "when options" do
      describe "are not empty" do
        let option: %Option{name: "op1", label: "Option 1", selected: false}
        let options: [option()]

        it "encodes the options" do
           expect(subject()[:options]) |> to(eq([Option.encode(option())]))
        end
      end
      describe "are empty" do
        let options: []

        it "raises an ArgumentError" do
           expect(fn -> subject() end) |> to(raise_exception ArgumentError)
        end
      end
    end

    describe "a default object" do
      let element: %ChoiceRadio{name: name(), label: label(), options: options()}

      it "encodes required as false" do
        expect(subject()[:required]) |> to(eq(false))
      end

      it "encodes microcopy as empty" do
        expect(subject()[:microcopy]) |> to(eq(""))
      end

      it "encodes other_option to false" do
        expect(subject()[:other_option]) |> to(eq(false))
      end
    end
  end
end
