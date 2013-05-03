class ListsController < ApplicationController

  def index
    @lists = List.where(user_id: current_user.id)
  end

  def new
    @list = List.new
  end

  def create
    # Here, the list's owner is being set to the currently signed in user.
    # Devise gives us the ability to use "current_user" when there is a signed in user.
    # We could do the merging of parametrs in two lines as well:
    # @list = List.new(params[:list])
    # @list.user_id = current_user.id
    @list = List.new(params[:list].merge(user_id: current_user.id) )
    if @list.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @list = List.find(params[:id])
  end


  # Use the destroy action to delete a record in the database
  def destroy
    list = List.find(params[:id])
    list.destroy
    # After deletion redirect to the Lists index page
    redirect_to lists_path
  end

end
