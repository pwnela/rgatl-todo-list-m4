require 'spec_helper'

describe 'list' do

  it 'should be signed into application before viewing lists' do
    visit root_path
    page.should have_content "Sign in"
  end

  it 'can sign into application and view lists' do
    user = User.create(username: "test_user", password: "password")
    visit root_path
    fill_in "user_username", with: "test_user"
    fill_in "user_password", with: "password"
    click_button "Sign in"

    page.should_not have_content "Sign in"
    page.should have_content "To-Do List"
  end

end
