defmodule GatherContext.API.FileSpec do
  use ESpec
  alias GatherContext.API.{Client, File}
  alias GatherContext.Types.Item

  describe "get" do
    describe "builds a %GatherContext.Types.File object" do

      let :response, do: {:ok, [%{
        "id" => 1,
        "user_id" => 1,
        "item_id" => 1,
        "field" => "abc123",
        "type" => "1",
        "url" => "http://link.to/filename.png",
        "filename" => "original.png",
        "size" => 123456,
        "created_at" => "2015-12-10 18:49:17",
        "updated_at" => "2015-12-10 18:49:17"
      }]}

      let :client, do: %Client{}
      before do: allow(Client).to accept(:get, fn(%Client{}, _) -> response() end)

      subject do: File.get(client(), %Item{id: 1}) |> elem(1) |> List.first

      it "which has an id" do
        expect(subject().id) |> to(eq(1))
      end

      it "which has a user id" do
        expect(subject().user_id) |> to(eq(1))
      end

      it "which has an item id" do
        expect(subject().item_id) |> to(eq(1))
      end

      it "which has a field" do
        expect(subject().field) |> to(eq("abc123"))
      end

      it "which has a type" do
        expect(subject().type) |> to(eq(1))
      end

      it "which has a url" do
        expect(subject().url) |> to(eq("http://link.to/filename.png"))
      end

      it "which has a filename" do
        expect(subject().filename) |> to(eq("original.png"))
      end

      it "which has a size" do
        expect(subject().size) |> to(eq(123456))
      end

      it "which has a created_at" do
        expect(subject().created_at) |> to(eq("2015-12-10 18:49:17"))
      end

      it "which has a updated_at" do
        expect(subject().updated_at) |> to(eq("2015-12-10 18:49:17"))
      end
    end
  end
end
