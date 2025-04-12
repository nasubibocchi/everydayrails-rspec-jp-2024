require 'rails_helper'

RSpec.describe Note, type: :model do
  it "returns notes that match the search term" do
    user = User.create(
      first_name: "John",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "“dottle-nouveau-pavilion-tights-furze",
    )

    project = user.projects.create(name: "Test Project")

    note1 = project.notes.create(
      message: "This is the first note",
      user: user,
    )
    note2 = project.notes.create(
      message: "This is the second note",
      user: user,
    )
    note3 = project.notes.create(
      message: "First, preheat the oven",
      user: user,
    )

    expect(Note.search("first")).to include(note1, note3)
    expect(Note.search("first")).not_to include(note2)
  end

  it "returns an empty collection when no results are found" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    project = user.projects.create(name: "Test Project")

    note1 = project.notes.create(
      message: "This is the first note",
      user: user,
    )
    note2 = project.notes.create(
      message: "This is the second note",
      user: user,
    )
    note3 = project.notes.create(
      message: "First, preheat the oven",
      user: user,
    )
    expect(Note.search("message")).to be_empty
  end

  # my learning
  it "is valid with a user, project, and message" do
    user = User.create(
      first_name: "John",
      last_name: "Tester",
      email: "johntester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    project = user.projects.create(name: "Test Project")
    note = project.notes.create(
      message: "This is a test note",
      user: user,
    )
    expect(note).to be_valid
  end

  it "is invalid without a project" do
    user = User.create(
      first_name: "John",
      last_name: "Tester",
      email: "johntester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    note = Note.new(
      message: "This is a test note",
      user: user,
    )
    note.valid?
    expect(note.errors[:project]).to include("must exist")
  end
  
  it "is invalid without a message" do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end
end
