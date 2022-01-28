class AddRemindAtToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :remind_at, :datetime
  end
end
