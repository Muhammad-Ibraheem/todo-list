# frozen_string_literal: true

class AddLastReminderSentAtToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :last_reminder_sent_at, :datetime
  end
end
