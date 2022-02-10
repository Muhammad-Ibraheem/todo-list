# frozen_string_literal: true

class AddReminderColumnsToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :remind_at, :datetime
    add_column :todos, :reminder_frequency, :string
    add_column :todos, :last_reminder_sent_at, :datetime
  end
end
