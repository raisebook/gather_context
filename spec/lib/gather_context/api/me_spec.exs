defmodule GatherContext.API.MeSpec do
  use ESpec
  alias GatherContext.API.{Client,Me}

  describe "get" do
    describe "builds a %GatherContext.Types.Me object" do

      let :response, do: {:ok, %{
        "email" => "andrew@gathercontent.com",
        "first_name" => "Andrew",
        "last_name" => "Cairns",
        "timezone" => "UTC",
        "language" => "en_AU",
        "gender" => "Male",
        "avatar" => "http://image-url.com"
      }}

      let :client, do: %Client{}
      before do: allow(Client).to accept(:get, fn(%Client{}, _) -> response() end)

      subject do: Me.get(client()) |> elem(1)

      it "which has an email address" do
        expect(subject().email) |> to(eq("andrew@gathercontent.com"))
      end

      it "which has a first name" do
        expect(subject().first_name) |> to(eq("Andrew"))
      end

      it "which has a last name" do
        expect(subject().last_name) |> to(eq("Cairns"))
      end

      it "which has a timezone" do
        expect(subject().timezone) |> to(eq("UTC"))
      end

      it "which has a language" do
        expect(subject().language) |> to(eq("en_AU"))
      end

      it "which has a gender" do
        expect(subject().gender) |> to(eq("Male"))
      end

      it "which has a avatar" do
        expect(subject().avatar) |> to(eq("http://image-url.com"))
      end
    end
  end
end
