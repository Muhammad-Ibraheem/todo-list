# frozen_string_literal: true

module Api
  module V1
    class TodosController < ApplicationController
      before_action :set_todo, only: %i[update destroy show]

      def index
        @todos = current_user.todos
        render json: TodosRepresenter.new(@todos).as_json
      end

      def create
        @todo = current_user.todos.new(todo_params)
        if @todo.save
          render json: TodoRepresenter.new(@todo).as_json, status: :created
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: TodosRepresenter.new(@todo).as_json
      end

      def update
        if @todo.update(todo_params)
          render json: TodoRepresenter.new(@todo).as_json
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @todo.destroy
        head :no_content
      end

      private

      def set_todo
        @todo = Todo.find(params[:id])
      end

      def todo_params
        params.permit(:title, :remind_at, :completed_at, :reminder_frequency, :expected_completion_time,
                      :last_reminder_sent_at)
      end
    end
  end
end
