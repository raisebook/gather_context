defmodule GatherContext.Types.Config.FilesSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.Config.Files

    let name: "el2"
    let required: true
    let label: "Photos"
    let microcopy: "Upload photos"

    let element: %Files{name: name(), required: required(), label: label(), microcopy: microcopy()}

    subject do: Files.encode(element())

    it "encodes type" do
      expect(subject()[:type]) |> to(eq("files"))
    end

    describe "when name" do
      describe "is not empty" do
        let name: "el2"

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
        let label: "Photos"

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

    describe "a default object" do
      let element: %Files{name: name(), label: label()}

      it "encodes required as false" do
        expect(subject()[:required]) |> to(eq(false))
      end

      it "encodes microcopy as empty" do
        expect(subject()[:microcopy]) |> to(eq(""))
      end
    end
  end
end
