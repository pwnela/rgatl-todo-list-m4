require 'spec_helper'

describe 'list' do
  # Use let and let! to define a helper method that will be accessible
  # for all your tests in the scope of this file
  # https://www.relishapp.com/rspec/rspec-core/v/2-6/docs/helper-methods/let-and-let
  let!(:user) { User.create(username: "test_user", password: "password") }
  let!(:list) { List.create(name: "List Name", user_id: user.id) }

  before do
    # Using a test helper from Warden, a tool that the devise gem uses for authentication
    # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
    login_as(user, scope: :user)
  end

  context 'management' do
    before do
      visit root_path
    end

    it 'should display its name on the list index page' do
      page.should have_content list.name
    end

    it 'can be created via the new list page' do
      click_link "New List"
      # To find the element name, in Chrome, you can right click on the field
      # and select "Inspect Element" where you'll see the rendered HTML
      fill_in "list_name", with: "Test List Name"
      click_button "Create List"
      page.should have_content "Test List Name"
    end

    it 'can be viewed by itself via the show list page' do
      click_link list.name
      page.should have_content list.name
    end

    it 'can be deleted' do
      click_link list.name
      click_link 'Delete List'
      page.should_not have_content list.name
    end
  end

  context 'with tasks' do
    # You can use the create method for a list's tasks
    # to create tasks that belong to a list
    # http://guides.rubyonrails.org/association_basics.html
    let!(:grocery_store_task) { list.tasks.create(description: "Buy groceries") }
    let!(:laundry_task) { list.tasks.create(description: "Do laundry") }
    let!(:ironing_task) { list.tasks.create(description: "Iron cape") }
    let!(:save_world_task) { list.tasks.create(description: "Save the world") }

    before do
      grocery_store_task.mark_complete
      visit root_path
      click_link list.name
    end

    it 'shows its tasks on the show list page' do
      page.should have_content grocery_store_task.description
      page.should have_content laundry_task.description
      page.should have_content ironing_task.description
      page.should have_content save_world_task.description
    end

    it 'displays tasks that are marked complete with the description scratched off' do
      page.should_not have_css("del", text: laundry_task.description)
      page.should have_css("del", text: grocery_store_task.description)
    end

    it 'displays how many tasks completed out the the total number of tasks on the list' do
      bad_list = List.create(name: "Bad List", user_id: user.id)
      bad_list.tasks.create(description: "Be grumpy")
      bad_list.tasks.create(description: "Throw things")
      bad_list.tasks.create(description: "Lose friends")

      visit root_path
      page.should have_content "#{list.name} (1/4 tasks completed)"
      page.should have_content "Bad List (0/3 tasks completed)"
    end
  end

end
