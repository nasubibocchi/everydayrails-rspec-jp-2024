require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    before do
      @user = User.create(
        first_name: "John",
        last_name: "Tester",
        email: "johntester@example.com",
        password: "dottle-nouveau-pavilion-tights-furze",
      )
    end

    it "is valid with name and user" do
      project = Project.new(
        name: "Test Project",
        owner: @user,
      )
      expect(project).to be_valid
    end

    it "is invalid without a name" do
      project = Project.new(
        name: nil,
        owner: @user,
      )
      project.valid?
      expect(project.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an owner" do
      project = Project.new(
        name: "Test Project",
        owner: nil,
      )
      project.valid?
      expect(project.errors[:owner]).to include("must exist")
    end
  end

  it "does not allow duplicate project names for the same user" do
    user = User.create(
      first_name: "John",
      last_name: "Doe",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    user.projects.create(name: "Test Project")

    new_project = user.projects.build(name: "Test Project")
    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allows duplicate project names for different users" do
    user = User.create(
      first_name: "John",
      last_name: "Doe",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    user.projects.create(name: "Test Project")

    other_user = User.create(
      first_name: "Jane",
      last_name: "Smith",
      email: "janetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    other_project = other_user.projects.build(name: "Test Project")
    
    other_project.valid?
    expect(other_project).to be_valid
    expect(other_project.errors[:name]).not_to include("has already been taken")
  end
end
