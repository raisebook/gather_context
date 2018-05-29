defmodule GatherContext.Types.Config.SectionSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.Config.Section

    let name: "el3"
    let title: "Title"
    let subtitle: "<p>How goes it?</p>"

    let element: %Section{name: name(), title: title(), subtitle: subtitle()}

    subject do: Section.encode(element())

    it "encodes type" do
      expect(subject()[:type]) |> to(eq("section"))
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

    describe "when title" do
      describe "is not empty" do
        let title: "Title"

        it "encodes the title" do
          expect(subject()[:title]) |> to(eq(title()))
        end
      end

      describe "is empty" do
        let title: ""

        it "raises an ArgumentError" do
           expect(fn -> subject() end) |> to(raise_exception ArgumentError)
        end
      end
    end

    it "encodes subtitle" do
      expect(subject()[:subtitle]) |> to(eq(subtitle()))
    end


    describe "a default object" do
      let element: %Section{name: name(), title: title()}

      it "encodes subtitle as empty" do
        expect(subject()[:subtitle]) |> to(eq(""))
      end
    end
  end
end
