require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @user = User.create(
      first_name: "John",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "“dottle-nouveau-pavilion-tights-furze",
    )

    @project = @user.projects.create(name: "Test Project")
  end

  describe "search message for a term" do
    before do
      @note1 = @project.notes.create(
        message: "This is the first note",
        user: @user,
      )
      @note2 = @project.notes.create(
        message: "This is the second note",
        user: @user,
      )
      @note3 = @project.notes.create(
        message: "First, preheat the oven",
        user: @user,
      )
    end
    context "when a match is found" do
      it "returns the notes that match the search term" do
        expect(Note.search("first")).to include(@note1, @note3)
        expect(Note.search("first")).not_to include(@note2)
      end
    end

    context "when no match is found" do
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty
      end
    end
  end

  # my learning
  it "is valid with a user, project, and message" do
    note = @project.notes.create(
      message: "This is a test note",
      user: @user,
    )
    # note = Note.new(
    #   message: "This is a test note",
    #   user: @user,
    #   project: @project,
    # )
    expect(note).to be_valid
  end

  it "is invalid without a project" do
    note = Note.new(
      message: "This is a test note",
      user: @user,
    )
    note.valid?
    expect(note.errors[:project]).to include("must exist")
  end
  
  it "is invalid without a message" do
    note = Note.new(message: nil, user: @user, project: @project)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
    expect(note.errors[:user]).not_to include("must exist")
    expect(note.errors[:project]).not_to include("must exist")
  end
end
