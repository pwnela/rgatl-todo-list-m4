require 'spec_helper'

describe ListsController do

  it 'should assign the current user as the list owner on create' do
    user = User.create(username: "test_user")
    # Using a devise test helper to sign in the user for this test
    # https://github.com/plataformatec/devise#test-helpers
    sign_in user

    post :create, list: {name: "Test List"}
    list = List.find_by_name("Test List")
    list.user.should == user
  end


  it 'should only show lists that belong to the currently signed in user' do
    user1 = User.create(username: "test_user1")
    user2 = User.create(username: "test_user2")

    # Using a devise test helper to sign in the user for this test
    # https://github.com/plataformatec/devise#test-helpers
    sign_in user1

    get :index

    # The 'to_a' call turns the user1.lists ActiveRecord relation into an array, so that
    # the comparison between assigns[:lists] (an array) and user1.lists (ActiveRecord relation)
    # can be made. This explains it a bit better:
    # http://asciicasts.com/episodes/239-activerecord-relation-walkthrough
    assigns[:lists].should eq user1.lists.to_a
    assigns[:lists].should_not eq user2.lists.to_a
  end
  
end
