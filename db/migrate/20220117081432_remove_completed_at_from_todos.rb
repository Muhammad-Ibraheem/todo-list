# frozen_string_literal: true

class RemoveCompletedAtFromTodos < ActiveRecord::Migration[7.0]
  def change
    remove_column :todos, :completed_at
  end
end
