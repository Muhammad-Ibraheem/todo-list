# frozen_string_literal: true

namespace :todos_reminders do
  desc 'reminders for todos'
  task reminders: :environment do
    TodoReminder.todos_reminders
  end
end
