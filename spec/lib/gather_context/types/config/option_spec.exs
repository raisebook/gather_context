defmodule GatherContext.Types.Config.OptionSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.Config.Option

    let name: "op1"
    let label: "Option 1"
    let selected: false

    let element: %Option{name: name(), label: label(), selected: selected()}

    subject do: Option.encode(element())

    describe "when name" do
      describe "is not empty" do
        let name: "label"

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
        let label: "Option 1"

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

    it "encodes selected" do
      expect(subject()[:selected]) |> to(eq(selected()))
    end


    describe "a default object" do
      let element: %Option{name: name(), label: label()}

      it "encodes selected as false" do
        expect(subject()[:selected]) |> to(eq(false))
      end
    end
  end
end
