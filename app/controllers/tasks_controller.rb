class TasksController < ApplicationController

  def new
    @task = Task.new
    # We will use a hidden field in tasks/new.html.erb to pass the task's list id to the create action.
    # This is how the task is associated to the right list.
    # params[:list_id] is populated in the link constructed on lines 6 and 8 in lists/show.html.erb
    # (Note: there is a better way to do this. Check out "build" on http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html.)
    @list = List.find(params[:list_id])
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to list_path(@task.list)
    else
      render 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
    @list = @task.list
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
    redirect_to list_path(@task.list)
  end

  def destroy
    task = Task.find(params[:id])

    # save the list before deleting the task so you
    # can redirect back to the list after destroying the task
    list = task.list
    task.destroy
    redirect_to list_path(list)
  end

end
