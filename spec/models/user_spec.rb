require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with first name, last name, email, and password" do
    user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user = User.new(
      first_name: nil,
      last_name: "Doe",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user.valid?
    # ↓を実行するとvalid?が実行されてerrorsに値が入る
    # expect(user).to be_invalid
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    user = User.new(
      first_name: "John",
      last_name: nil,
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: nil,
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  it "returns a user's full name as a string"
end
