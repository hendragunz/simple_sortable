class TodoListsController < ApplicationController
  # GET - todo_lists_url
  def index
    @todo_lists = TodoList.includes(:todo_items)
  end

  # GET - todo_list_url(id)
  def show
    @todo_items = todo.todo_items
  end

  # GET - new_todo_list_url
  def new
    @todo = TodoList.new
  end

  # POST - new_todo_lists_url
  def create
    @todo = TodoList.new filter_param
    if @todo.save
      gflash :success => "Success create Todo List"
      redirect_to action: 'index'
    else
      gflash :error => @todo.errors.full_messages.join('<br />')
      render action: 'new'
    end
  end

  # GET - edit_todo_list_url(id)
  def edit

  end

  # PUT - todo_list_url(id)
  def update

  end

  # DELETE - todo_list_url(id)
  def destroy

  end


  def update_row
    @todo_item = todo.todo_items.find params[:todo_item_id]
    @success = @todo_item.set_list_position(params[:row].to_i + 1)
    respond_to do |format|
      format.js
    end
  rescue
    respond_to do |format|
      format.js
    end
  end


  def move_row
    @from_todo  = TodoList.find params[:from_todo_list_id]
    @todo_item  = @from_todo.todo_items.find params[:todo_item_id]
    @to_todo    = TodoList.find params[:target_todo_list_id]

    @todo_item.remove_from_list
    @todo_item.todo_list = @to_todo
    @todo_item.save
    @todo_item.insert_at(params[:row].to_i + 1)

    @success = @todo_item.save
    respond_to do |format|
      format.js
    end
  end

  private

    # filter paramater for create and update
    def filter_param
      params[:todo_list].slice(:name, :description, :todo_items_attributes)
    end

    # prepare selected todo
    def todo
      @todo ||= TodoList.find params[:id]
    end
end
