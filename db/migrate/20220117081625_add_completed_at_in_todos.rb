# frozen_string_literal: true

class AddCompletedAtInTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :completed_at, :datetime
  end
end
