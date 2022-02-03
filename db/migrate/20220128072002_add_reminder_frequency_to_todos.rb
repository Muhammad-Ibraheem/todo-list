# frozen_string_literal: true

class AddReminderFrequencyToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :reminder_frequency, :string
  end
end
