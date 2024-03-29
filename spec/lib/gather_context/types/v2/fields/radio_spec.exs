defmodule GatherContext.Types.V2.Fields.RadioSpec do
  use ESpec

  describe "encode" do
    alias GatherContext.Types.V2.Fields.Radio
    alias GatherContext.Types.V2.Fields.Radio.Metadata
    alias GatherContext.Types.V2.Fields.Radio.ChoiceFields
    alias GatherContext.Types.V2.Fields.Radio.Option

    let(uuid: "00000000-0000-0000-0000-000000000000")
    let(label: "Label")
    let(instructions: "<p>Instructions</p>")

    let(
      metadata: %Metadata{
        choice_fields: %ChoiceFields{
          options: [
            %Option{
              optionId: "00000000-0000-0000-0000-000000000000",
              label: "label"
            }
          ]
        }
      }
    )

    let(
      element: %Radio{
        uuid: uuid(),
        label: label(),
        instructions: instructions(),
        metadata: metadata()
      }
    )

    subject(do: Radio.encode(element()))

    it "encodes type" do
      expect(subject()[:type]) |> to(eq("choice_radio"))
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

    describe "when metadata" do
      describe "is not nil" do
        describe "when choice_fields" do
          describe "is not nil" do
            describe "when options" do
              describe "is not empty" do
                let(
                  metadata: %Metadata{
                    choice_fields: %ChoiceFields{
                      options: [
                        %Option{
                          optionId: "00000000-0000-0000-0000-000000000000",
                          label: "label"
                        }
                      ]
                    }
                  }
                )

                it "encodes the options" do
                  expect(subject()[:metadata][:choice_fields][:options])
                  |> to(eq([%{optionId: "00000000-0000-0000-0000-000000000000", label: "label"}]))
                end
              end

              describe "is empty" do
                let(metadata: %Metadata{choice_fields: %ChoiceFields{options: []}})

                it "raises an ArgumentError" do
                  expect(fn -> subject() end) |> to(raise_exception(ArgumentError))
                end
              end

              describe "is nil" do
                let(metadata: %Metadata{choice_fields: %ChoiceFields{options: nil}})

                it "raises an ArgumentError" do
                  expect(fn -> subject() end) |> to(raise_exception(ArgumentError))
                end
              end
            end

            describe "when other_options" do
              describe "is nil" do
                let(
                  metadata: %Metadata{
                    choice_fields: %ChoiceFields{
                      options: [
                        %Option{
                          optionId: "00000000-0000-0000-0000-000000000000",
                          label: "label"
                        }
                      ]
                    }
                  }
                )

                it "omits the attribute" do
                  expect(subject()[:metadata][:choice_fields] |> Map.has_key?(:other_options))
                  |> to(eq(false))
                end
              end

              describe "is not nil" do
                let(
                  metadata: %Metadata{
                    choice_fields: %ChoiceFields{
                      options: [
                        %Option{
                          optionId: "00000000-0000-0000-0000-000000000000",
                          label: "label"
                        }
                      ],
                      other_options: %Option{
                        optionId: "00000001-0000-0000-0000-000000000000",
                        label: "label 2"
                      }
                    }
                  }
                )

                it "encodes the attribute" do
                  expect(subject()[:metadata][:choice_fields][:other_options])
                  |> to(
                    eq(%{
                      optionId: "00000001-0000-0000-0000-000000000000",
                      label: "label 2"
                    })
                  )
                end
              end
            end
          end

          describe "is nil" do
            let(metadata: %Metadata{choice_fields: nil})

            it "raises an ArgumentError" do
              expect(fn -> subject() end) |> to(raise_exception(ArgumentError))
            end
          end
        end
      end

      describe "is nil" do
        let(metadata: nil)

        it "raises an ArgumentError" do
          expect(fn -> subject() end) |> to(raise_exception(ArgumentError))
        end
      end
    end

    describe "a default object" do
      let(
        element: %Radio{
          label: label(),
          metadata: metadata()
        }
      )

      it "omits uuid" do
        expect(subject() |> Map.has_key?(:uuid)) |> to(eq(false))
      end

      it "omits instructions" do
        expect(subject() |> Map.has_key?(:instructions)) |> to(eq(false))
      end
    end
  end
end
