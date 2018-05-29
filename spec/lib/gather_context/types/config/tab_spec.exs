defmodule GatherContext.Types.Config.TabSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.Config.Tab

    let name: "label"
    let label: "Content"
    let hidden: false
    let elements: []

    let element: %Tab{name: name(), label: label(), hidden: hidden(), elements: elements()}

    subject do: Tab.encode(element())

    it "encodes type" do
      expect(subject()[:type]) |> to(eq("tab"))
    end

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
        let label: "Blog post"

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

    it "encodes hidden" do
      expect(subject()[:hidden]) |> to(eq(hidden()))
    end

    it "encodes elements" do
      expect(subject()[:elements]) |> to(eq(elements()))
    end

    describe "a default object" do
      let element: %Tab{name: name(), label: label()}

      it "encodes required as false" do
        expect(subject()[:hidden]) |> to(eq(false))
      end

      it "encodes elements as empty" do
        expect(subject()[:elements]) |> to(eq([]))
      end
    end
  end
end
