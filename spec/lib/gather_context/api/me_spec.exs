defmodule GatherContext.API.MeSpec do
  use ESpec

  let :response, do: {:ok, %{
    "email" => "andrew@gathercontent.com",
    "first_name" => "Andrew",
    "last_name" => "Cairns",
    "timezone" => "UTC",
    "language" => "en_AU",
    "gender" => "Male",
    "avatar" => "http://image-url.com"
  }}

  let :client, do: %GatherContext.API.Client{get: fn(_) -> response() end}

  subject do: GatherContext.API.Me.get(client())

  describe "get" do
    describe "builds a %GatherContext.API.ME object" do
      subject do: GatherContext.API.Me.get(client()) |> elem(1)

      it "has an email address" do
        expect(subject().email) |> to(eq("andrew@gathercontent.com"))
      end

      it "has a first name" do
        expect(subject().first_name) |> to(eq("Andrew"))
      end

      it "has a last name" do
        expect(subject().last_name) |> to(eq("Cairns"))
      end

      it "has a timezone" do
        expect(subject().timezone) |> to(eq("UTC"))
      end

      it "has a language" do
        expect(subject().language) |> to(eq("en_AU"))
      end

      it "has a gender" do
        expect(subject().gender) |> to(eq("Male"))
      end

      it "has a avatar" do
        expect(subject().avatar) |> to(eq("http://image-url.com"))
      end
    end
  end
end
