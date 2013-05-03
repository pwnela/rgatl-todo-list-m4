require 'spec_helper'

describe List do
  it 'should have a name' do
    list = List.new(name: "Test To-Do List")
    list.name.should eql "Test To-Do List"
  end

  it 'is not valid if it does not have a name' do
    list = List.new
    list.should_not be_valid
  end

  it 'should have tasks' do
    list = List.new(name: "Test To-Do List")
    grocery_store_task = Task.create(description: "Buy groceries")
    laundry_task = Task.create(description: "Do laundry")
    ironing_task = Task.create(description: "Iron cape")
    save_world_task = Task.create(description: "Save the world")

    list.add_task(grocery_store_task)
    list.add_task(laundry_task)
    list.add_task(ironing_task)
    list.add_task(save_world_task)

    list.tasks.should == [grocery_store_task, laundry_task, ironing_task, save_world_task]
  end

  it 'knows which of its tasks have not been completed' do
    list = List.new(name: "Test To-Do List")
    grocery_store_task = Task.create(description: "Buy groceries")
    laundry_task = Task.create(description: "Do laundry")
    ironing_task = Task.create(description: "Iron cape")
    save_world_task = Task.create(description: "Save the world")

    list.add_task(grocery_store_task)
    list.add_task(laundry_task)
    list.add_task(ironing_task)
    list.add_task(save_world_task)

    grocery_store_task.mark_complete
    save_world_task.mark_complete

    list.incomplete_tasks.should == [laundry_task, ironing_task]
  end

  it 'knows which of its tasks have not been completed' do
    list = List.new(name: "Test To-Do List")
    grocery_store_task = Task.create(description: "Buy groceries")
    laundry_task = Task.create(description: "Do laundry")
    ironing_task = Task.create(description: "Iron cape")
    save_world_task = Task.create(description: "Save the world")

    list.add_task(grocery_store_task)
    list.add_task(laundry_task)
    list.add_task(ironing_task)
    list.add_task(save_world_task)

    grocery_store_task.mark_complete
    save_world_task.mark_complete

    list.completed_tasks.should == [grocery_store_task, save_world_task]
  end
end
