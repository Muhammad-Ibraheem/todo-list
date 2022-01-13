class TodosController < ApplicationController 
    before_action :set_todo, only: [:update, :destroy, :show] 

    def index 
        @todos = Todo.all
        render json: @todos
    end 

    def show 
  render json: @todo
    end

def create 
@todo = Todo.new(todo_params) 
if @todo.save 
    render json: @todo 
end
end



    private 

    def set_todo 
        @todo = Todo.find(params[:id])
    end 

    def todo_params
params.require(:todo).permit(:id, :title, :done)
    end
end
