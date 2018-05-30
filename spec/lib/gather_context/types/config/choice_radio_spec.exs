defmodule GatherContext.Types.Config.ChoiceRadioSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.Config.{ChoiceRadio,Option,OtherOption}

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

    it "encodes other_option" do
      expect(subject()[:other_option]) |> to(eq(other_option()))
    end

    describe "when other_option" do
      describe "is true" do
        let other_option: true

        let option_1: %Option{name: "op1", label: "Option 1", selected: true}
        let option_2: %Option{name: "op2", label: "Option 2", selected: false}
        let other_option_1: %OtherOption{name: "op3", label: "Other", value: "Something", selected: false}
        let other_option_2: %OtherOption{name: "op3", label: "Other", value: "Something", selected: false}
        let options: [option_1(), option_2(), other_option_1()]

        describe "and options" do
          describe "are empty" do
            let options: []

            it "raises an ArgumentError" do
               expect(fn -> subject() end) |> to(raise_exception ArgumentError)
            end
          end

          describe "only includes one option" do
            let options: [option_1()]

            it "raises an ArgumentError" do
               expect(fn -> subject() end) |> to(raise_exception ArgumentError)
            end
          end

          describe "doesn't include an other option" do
            let options: [option_1(), option_2()]

            it "raises an ArgumentError" do
               expect(fn -> subject() end) |> to(raise_exception ArgumentError)
            end
          end

          describe "includes an other option" do
            let options: [option_1(), option_2(), other_option_1()]

            it "encodes the options" do
               expect(subject()[:options]) |> to(eq([Option.encode(option_1()), Option.encode(option_2()), OtherOption.encode(other_option_1())]))
            end
          end

          describe "includes an other option not in the last position" do
            let options: [option_1(), other_option_1(), option_2()]

            it "puts the other option at the end" do
               expect(subject()[:options]) |> to(eq([Option.encode(option_1()), Option.encode(option_2()), OtherOption.encode(other_option_1())]))
            end
          end

          describe "includes more than one other_option" do
            let options: [option_1(), other_option_1(), other_option_2()]

            it "raises an ArgumentError" do
               expect(fn -> subject() end) |> to(raise_exception ArgumentError)
            end
          end
        end
      end

      describe "is false" do
        let other_option: false

        describe "and options" do
          describe "are not empty" do
            let option_1: %Option{name: "op1", label: "Option 1", selected: true}
            let option_2: %Option{name: "op2", label: "Option 2", selected: false}
            let other_option_1: %OtherOption{name: "op3", label: "Other", value: "Something", selected: false}
            let options: [option_1(), option_2()]

            it "encodes the options" do
               expect(subject()[:options]) |> to(eq([Option.encode(option_1()), Option.encode(option_2())]))
            end

            describe "and the number of options that are selected" do
              describe "is zero" do
                let option_1: %Option{name: "op1", label: "Option 1", selected: false}
                let option_2: %Option{name: "op2", label: "Option 2", selected: false}

                it "encodes the options" do
                   expect(subject()[:options]) |> to(eq([Option.encode(option_1()), Option.encode(option_2())]))
                end
              end

              describe "is one" do
                let option_1: %Option{name: "op1", label: "Option 1", selected: true}
                let option_2: %Option{name: "op2", label: "Option 2", selected: false}

                it "encodes the options" do
                   expect(subject()[:options]) |> to(eq([Option.encode(option_1()), Option.encode(option_2())]))
                end
              end

              describe "is greater than one" do
                let option_1: %Option{name: "op1", label: "Option 1", selected: true}
                let option_2: %Option{name: "op2", label: "Option 2", selected: true}

                it "raises an ArgumentError" do
                  expect(fn -> subject() end) |> to(raise_exception ArgumentError)
                end
              end
            end

            describe "one of the options is an Other Option" do
              let options: [option_1(), option_2(), other_option_1()]

              it "raises an ArgumentError" do
                expect(fn -> subject() |> Apex.ap end) |> to(raise_exception ArgumentError)
              end
            end
          end

          describe "are empty" do
            let options: []

            it "raises an ArgumentError" do
               expect(fn -> subject() end) |> to(raise_exception ArgumentError)
            end
          end
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
