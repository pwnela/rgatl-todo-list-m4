require 'spec_helper'

describe TasksController do
  let!(:user) { User.create(username: "test_user", password: "password") }
  let!(:list) { List.create(name: "List Name", user_id: user.id) }
  let!(:task1) { Task.create(description: "Task 1", list_id: list.id, priority: 1) }
  let!(:task2) { Task.create(description: "Task 2", list_id: list.id, priority: 2) }
  let!(:task3) { Task.create(description: "Task 3", list_id: list.id, priority: 3) }
  let!(:task4) { Task.create(description: "Task 4", list_id: list.id, priority: 4) }
  let!(:task5) { Task.create(description: "Task 5", list_id: list.id, priority: 5) }
  let!(:task6) { Task.create(description: "Task 6", list_id: list.id, priority: 6) }

  before do
    sign_in user
  end

  it 'is assigned a default priority on creation' do
    post :create, task: {description: "New Task", list_id: list.id}
    post :create, task: {description: "Newer Task", list_id: list.id}
    post :create, task: {description: "Newest Task", list_id: list.id}

    task = Task.find_by_description("Newest Task")
    list.tasks.prioritize.last.should == task
  end

  it 'can be prioritized higher in its list' do
    post :change_priority, id: task6, priority: 1
    list.tasks.prioritize.should == [task6, task1, task2, task3, task4, task5]
  end

   it 'can be prioritized lower in its list' do
    post :change_priority, id: task5, priority: 2
    list.tasks.prioritize.should == [ task1, task5, task2, task3, task4, task6]
  end

end
