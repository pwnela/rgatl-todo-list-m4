require 'spec_helper'

describe 'list' do
  let!(:user) { User.create(username: "test_user", password: "password") }
  let!(:list) { List.create(name: "List Name", user_id: user.id) }

  before do
    # Using a test helper from Warden, a tool that the devise gem uses for authentication
    # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
    login_as(user, scope: :user)
  end

  context 'management' do

    it 'can add tasks from the show list page' do
      visit root_path
      click_link list.name
      click_link "Add Task"
      fill_in "task_description", with: "Get excited and make things"
      click_button "Create Task"

      page.should have_content "List Name"
      page.should have_content "Get excited and make things"
    end

    context 'of an existing task' do
      let!(:grocery_store_task) { list.tasks.create(description: "Buy groceries") }
      let!(:laundry_task) { list.tasks.create(description: "Do laundry") }

      before do
        visit root_path
        click_link list.name
        click_link grocery_store_task.description
      end

      it 'can be edited from the edit task page' do
        fill_in "task_description", with: "Helicopter lesson"
        click_button "Update Task"
        page.should have_content "List Name"
        page.should have_content "Helicopter lesson"
      end

      it 'can be deleted' do
        click_link 'Delete Task'
        page.should_not have_content grocery_store_task.description
      end
    end
  end

  context 'marking a task' do
    let!(:excited_task) { Task.create(description: "Get excited") }
    let!(:make_task) { Task.create(description: "Make things") }

    before do
      list.add_task(excited_task)
      list.add_task(make_task)
    end

    it 'allows a user to mark a task as completed' do
      visit list_path(list)
      click_link excited_task.description
      check "task_completed"
      click_button "Update Task"
      page.should_not have_css("del", text: make_task.description)
      page.should have_css("del", text: excited_task.description)
    end

    it 'allows a user to mark an incomplete task as not yet completed' do
      excited_task.mark_complete
      visit list_path(list)
      click_link excited_task.description
      uncheck "task_completed"
      click_button "Update Task"
      page.should_not have_css("del", text: excited_task.description)
    end
  end

  it 'allows a user to mark select a due date for the task' do
    date = Date.today + 5

    visit list_path(list)
    click_link "Add Task"
    fill_in "task_description", with: "Get excited and make things"
    select date.year, from: "task_deadline_1i"    
    select Date::MONTHNAMES[date.month], from: "task_deadline_2i"
    select date.day, from: "task_deadline_3i"
    click_button "Create Task"

    page.should have_content("5 more days until deadline")
  end

end
