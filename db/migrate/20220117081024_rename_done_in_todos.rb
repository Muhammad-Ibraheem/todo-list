# frozen_string_literal: true

class RenameDoneInTodos < ActiveRecord::Migration[7.0]
  def change
    rename_column :todos, :done, :completed_at
  end
end
