RgatlTodoList::Application.routes.draw do

  devise_for :users

  # These lines give us ALL of the standard routes for lists and tasks
  # The handling of these routes is done in the controllers.
  # http://guides.rubyonrails.org/routing.html#resources-on-the-web
  resources :lists
  resources :tasks

  # sets which route is the default location for application
  root to: "lists#index"
end
