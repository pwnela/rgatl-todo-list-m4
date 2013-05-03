require 'spec_helper'

describe User do
  it 'validates presence of username on creation' do
    user = User.new
    user.should_not be_valid
  end

  it 'validates that the username is unique on creation' do
    user1 = User.create(username: "test_user")
    user2 = User.new(username: "test_user")
    user2.should_not be_valid
  end

  it 'has an empty to-do list generated on creation' do
    user = User.create(username: "test_user")
    user.lists.present?.should == true
  end

end
