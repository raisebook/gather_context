defmodule SharedStatusSpec do
  use ESpec, shared: true

  it "sets the id" do
    expect(shared.id) |> to(eq(shared.id))
  end

  it "sets is_default" do
    expect(shared.subject.is_default) |> to(eq(shared.is_default))
  end

  it "sets the position" do
    expect(shared.subject.position) |> to(eq(shared.position))
  end

  it "sets the color" do
    expect(shared.subject.color) |> to(eq(shared.color))
  end

  it "sets the name" do
    expect(shared.subject.name) |> to(eq(shared.name))
  end

  it "sets the description" do
    expect(shared.subject.description) |> to(eq(shared.description))
  end

  it "sets the can_edit" do
    expect(shared.subject.can_edit) |> to(eq(shared.can_edit))
  end
end
