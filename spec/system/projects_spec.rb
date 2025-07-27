require 'rails_helper'

RSpec.describe "Projects", type: :system do
  # scenarioはitで書き換えることができる
  scenario "user creates a new project" do
    # arrangement
    user = FactoryBot.create(:user)
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # actiont + assertion
    expect {
      click_on "New Project"
      fill_in "Name", with: "New Project"
      fill_in "Description", with: "Trying out Capybara"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
      expect(page).to have_content("New Project")
      expect(page).to have_content("Owner: #{user.name}")
    }.to change(user.projects, :count).by(1)
  end

  scenario "guest adds a project" do
    visit projects_path
    # save_and_open_page
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
