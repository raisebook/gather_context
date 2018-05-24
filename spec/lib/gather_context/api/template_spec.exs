defmodule GatherContext.API.TemplateSpec do
  use ESpec
  alias GatherContext.API.{Client, Template,TemplateUsage}

  let :obj, do: %{
    "id" => 123456,
    "project_id" => 123456,
    "created_by" => 123456,
    "updated_by" => 123456,
    "name" => "Blog Theme",
    "description" => "Blog theme",
    "used_at" => "2015-08-26 17:03:20",
    "created_at" => 1440604320,
    "updated_at" => 1440608600,
    "usage" => %{
        "item_count" => 1
    }
  }

  describe "all" do
    let :response, do: {:ok, [obj()]}
    let :client, do: %Client{get: fn(_) -> response() end}
    subject do: (Template.all(client()) |> elem(1))

    it "returns a List" do
      expect(subject() |> length) |> to(eq(1))
    end

    describe "builds a List of %GatherContext.API.Template objects" do
      subject do: (Template.all(client()) |> elem(1) |> List.first)

      it "which has an id" do
        expect(subject().id) |> to(eq(123456))
      end

      it "which has a project id" do
        expect(subject().project_id) |> to(eq(123456))
      end

      it "which has a created by id" do
        expect(subject().created_by) |> to(eq(123456))
      end

      it "which has a updated by id" do
        expect(subject().updated_by) |> to(eq(123456))
      end

      it "which has a name" do
        expect(subject().name) |> to(eq("Blog Theme"))
      end

      it "which has a description" do
        expect(subject().description) |> to(eq("Blog theme"))
      end

      it "which has a used at field" do
        expect(subject().used_at) |> to(eq("2015-08-26 17:03:20"))
      end

      it "which has a created_at timestamp" do
        expect(subject().created_at) |> to(eq(1440604320))
      end

      it "which has a updated_at timestamp" do
        expect(subject().updated_at) |> to(eq(1440608600))
      end

      it "which has a usage field" do
        expect(subject().usage) |> to(eq(%TemplateUsage{item_count: 1}))
      end
    end
  end

  describe "get_account" do
    let :response, do: {:ok, obj()}
    let :client, do: %Client{get: fn(_) -> response() end}
    subject do: (Template.get_template(client(), 123456) |> elem(1))

    describe "builds a %GatherContext.API.Template object" do
      subject do: (Template.get_template(client(), 123456) |> elem(1))

      it "which has an id" do
        expect(subject().id) |> to(eq(123456))
      end

      it "which has a project id" do
        expect(subject().project_id) |> to(eq(123456))
      end

      it "which has a created by id" do
        expect(subject().created_by) |> to(eq(123456))
      end

      it "which has a updated by id" do
        expect(subject().updated_by) |> to(eq(123456))
      end

      it "which has a name" do
        expect(subject().name) |> to(eq("Blog Theme"))
      end

      it "which has a description" do
        expect(subject().description) |> to(eq("Blog theme"))
      end

      it "which has a used at field" do
        expect(subject().used_at) |> to(eq("2015-08-26 17:03:20"))
      end

      it "which has a created_at timestamp" do
        expect(subject().created_at) |> to(eq(1440604320))
      end

      it "which has a updated_at timestamp" do
        expect(subject().updated_at) |> to(eq(1440608600))
      end

      it "which has a usage field" do
        expect(subject().usage) |> to(eq(%TemplateUsage{item_count: 1}))
      end
    end
  end
end
