defmodule GatherContext.API.AccountSpec do
  use ESpec

  let :obj, do: %{
    "id" => "123456",
    "name" => "Example",
    "slug" => "example",
    "timezone" => "UTC"
  }

  describe "all" do
    let :response, do: {:ok, [obj()]}
    let :client, do: %GatherContext.API.Client{get: fn(_) -> response() end}
    subject do: (GatherContext.API.Account.all(client()) |> elem(1))

    it "returns a List" do
      expect(subject() |> length) |> to(eq(1))
    end

    describe "builds a List of %GatherContext.API.Account objects" do
      subject do: (GatherContext.API.Account.all(client()) |> elem(1) |> List.first)

      it "which has an id" do
        expect(subject().id) |> to(eq(123456))
      end

      it "which has a name" do
        expect(subject().name) |> to(eq("Example"))
      end

      it "which has a slug" do
        expect(subject().slug) |> to(eq("example"))
      end

      it "which has a timezone" do
        expect(subject().timezone) |> to(eq("UTC"))
      end
    end
  end

  describe "get_account" do
    let :response, do: {:ok, obj()}
    let :client, do: %GatherContext.API.Client{get: fn(_) -> response() end}
    subject do: (GatherContext.API.Account.get_account(client(), 123456) |> elem(1))

    describe "builds a %GatherContext.API.Account object" do
      subject do: (GatherContext.API.Account.get_account(client(), 123456) |> elem(1))

      it "which has an id" do
        expect(subject().id) |> to(eq(123456))
      end

      it "which has a name" do
        expect(subject().name) |> to(eq("Example"))
      end

      it "which has a slug" do
        expect(subject().slug) |> to(eq("example"))
      end

      it "which has a timezone" do
        expect(subject().timezone) |> to(eq("UTC"))
      end
    end
  end
end
