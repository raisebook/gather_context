defmodule GatherContext.Types.Config.OtherOptionSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.Config.OtherOption

    let name: "op1"
    let label: "Other"
    let selected: true
    let value: "Something"

    let element: %OtherOption{name: name(), label: label(), selected: selected(), value: value()}

    subject do: OtherOption.encode(element())

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

    describe "when selected" do
      describe "is true" do
        let selected: true
        let value: "Something"

        it "encodes value" do
          expect(subject()[:value]) |> to(eq(value()))
        end
      end

      describe "is false" do
        let selected: false

        describe "and value is set" do
          let value: "Something"

          it "encodes value to an empty string" do
            expect(subject()[:value]) |> to(eq(""))
          end
        end
      end
    end


    describe "a default object" do
      let element: %OtherOption{name: name(), label: label()}

      it "encodes selected as false" do
        expect(subject()[:selected]) |> to(eq(false))
      end

      it "encodes value as empty string" do
        expect(subject()[:value]) |> to(eq(""))
      end
    end
  end
end
