RgatlTodoList::Application.routes.draw do

  devise_for :users

  # These lines give us ALL of the standard routes for lists and tasks
  # The handling of these routes is done in the controllers.
  # http://guides.rubyonrails.org/routing.html#resources-on-the-web
  resources :lists
  resources :tasks do
    # Can define custom routes aside from the standard ones given to use by the "resouces" call.
    # We define that this will be a "put", and the "on: :member" tells rails to expect a task id
    # in the url.
    # http://guides.rubyonrails.org/routing.html#adding-more-restful-actions
    put :change_priority, on: :member
  end


  # sets which route is the default location for application
  root to: "lists#index"
end
