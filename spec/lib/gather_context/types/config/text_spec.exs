defmodule GatherContext.Types.Config.TextSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.Config.Text

    let name: "el1"
    let required: true
    let label: "Blog post"
    let value: "<p>Hello World</p>"
    let microcopy: "Content for the Blog Post"
    let limit_type: :words
    let limit: 1000
    let plain_text: false

    let text: %Text{name: name(), required: required(), label: label(), value: value(), microcopy: microcopy(), limit_type: limit_type(), limit: limit(), plain_text: plain_text()}

    subject do: Text.encode(text())

    it "encodes type" do
      expect(subject()[:type]) |> to(eq("text"))
    end

    describe "when name" do
      describe "is not empty" do
        let name: "el1"

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

    it "encodes required" do
      expect(subject()[:required]) |> to(eq(required()))
    end

    it "encodes value" do
      expect(subject()[:value]) |> to(eq(value()))
    end

    it "encodes microcopy" do
      expect(subject()[:microcopy]) |> to(eq(microcopy()))
    end

    describe "when limit_type" do
      describe "is :chars" do
        let limit_type: :chars

        it "encodes limit_type" do
          expect(subject()[:limit_type]) |> to(eq(:chars))
        end
      end

      describe "is :words" do
        let limit_type: :words

        it "encodes limit_type" do
          expect(subject()[:limit_type]) |> to(eq(:words))
        end
      end

      describe "is invalid" do
        let limit_type: :not_valid

        it "raises an ArgumentError" do
           expect(fn -> subject() end) |> to(raise_exception ArgumentError)
        end
      end
    end

    describe "when limit" do
      describe "is greater than 0" do
        let limit: 100
        it "encodes the limit" do
          expect(subject()[:limit]) |> to(eq(100))
        end
      end

      describe "is less than 0" do
        let limit: -100

        it "raises an ArgumentError" do
           expect(fn -> subject() end) |> to(raise_exception ArgumentError)
        end
      end
    end

    it "encodes plain_text" do
      expect(subject()[:plain_text]) |> to(eq(plain_text()))
    end

    describe "a default object" do
      let text: %Text{name: name(), label: label()}

      it "encodes required as false" do
        expect(subject()[:required]) |> to(eq(false))
      end

      it "encodes value as empty" do
        expect(subject()[:value]) |> to(eq(""))
      end

      it "encodes microcopy as empty" do
        expect(subject()[:microcopy]) |> to(eq(""))
      end

      it "encodes limit_type as :chars" do
        expect(subject()[:limit_type]) |> to(eq(:chars))
      end

      it "encodes limit as 0" do
        expect(subject()[:limit]) |> to(eq(0))
      end

      it "encodes plain_text as false" do
        expect(subject()[:plain_text]) |> to(eq(true))
      end
    end
  end
end
