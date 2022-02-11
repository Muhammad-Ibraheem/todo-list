# frozen_string_literal: true

class AddExpectedCompletionTimeToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :expected_completion_time, :time
  end
end
