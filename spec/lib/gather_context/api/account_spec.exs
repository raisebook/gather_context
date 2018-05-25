defmodule SharedAccount do
  use ESpec, shared: true

  it "which has an id" do
    expect(shared.subject().id) |> to(eq(shared.id))
  end

  it "which has a name" do
    expect(shared.subject().name) |> to(eq(shared.name))
  end

  it "which has a slug" do
    expect(shared.subject().slug) |> to(eq(shared.slug))
  end

  it "which has a timezone" do
    expect(shared.subject().timezone) |> to(eq(shared.timezone))
  end
end

defmodule GatherContext.API.AccountSpec do
  use ESpec
  alias GatherContext.API.Client
  alias GatherContext.API.Account

  let :obj, do: %{
    "id" => "123456",
    "name" => "Example",
    "slug" => "example",
    "timezone" => "UTC"
  }

  before subject: subject(),
          id: 123456,
          name: "Example",
          slug: "example",
          timezone: "UTC"

  describe "all" do
    let :response, do: {:ok, [obj()]}
    let :client, do: %Client{get: fn(_) -> response() end}
    subject do: (Account.all(client()) |> elem(1))

    it "returns a List" do
      expect(subject() |> length) |> to(eq(1))
    end

    describe "builds a List of %GatherContext.API.Account objects" do
      subject do: (Account.all(client()) |> elem(1) |> List.first)
      it_behaves_like(SharedAccount)
    end
  end

  describe "get_account" do
    let :response, do: {:ok, obj()}
    let :client, do: %Client{get: fn(_) -> response() end}
    subject do: (Account.get_account(client(), 123456) |> elem(1))

    describe "builds a %GatherContext.Types.Account object" do
      subject do: (Account.get_account(client(), 123456) |> elem(1))
      it_behaves_like(SharedAccount)
    end
  end
end
