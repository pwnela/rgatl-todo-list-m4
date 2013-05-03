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

  def change_priority
    task = Task.find(params[:id])
    list = task.list
    old_priority = task.priority
    new_priority = params[:priority].to_i   
    task.update_attributes(priority: new_priority)

    # If being decreased in priority, we have to also decrease the priority of the tasks that ranked between the old and new priority levels
    if old_priority > new_priority
      list.tasks.prioritize[new_priority -1..old_priority - 1].each do |demoted_task|
        demoted_task.update_attributes(priority: demoted_task.priority + 1) unless demoted_task == task
      end
    # If being increased in priority, we have to also increase the priority of the tasks ranked between the old and new priority levels
    elsif old_priority < new_priority
      list.tasks.prioritize[old_priority-1..new_priority-1].each do |promoted_task|
        promoted_task.update_attributes(priority: promoted_task.priority - 1) unless promoted_task == task
      end
    end
    
    redirect_to list_path(list)
  end

end
