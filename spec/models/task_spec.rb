require 'spec_helper'

describe Task do
  it 'should have a description' do
    task = Task.new(description: "Test Task")
    task.description.should eql "Test Task"
  end

  it 'is not valid if it does not have a description' do
    task = Task.new
    task.should_not be_valid
  end

  it 'is by default marked as incomplete' do
    task = Task.new(description: "New Test Task")
    task.should_not be_completed
  end

  it 'can be marked complete' do
    task = Task.new(description: "Test Task")
    task.mark_complete
    task.should be_completed
  end

  it 'tracks how far away its deadline is' do
    task = Task.new(description: "Test Task", deadline: (Date.today + 1.days) )
    task.days_left_to_complete.should == 1
  end

  it 'tracks if a deadline is past due' do
    task = Task.new(description: "Test Task", deadline: (Date.today - 1.days) )
    task.days_left_to_complete.should == -1
  end
end
