# frozen_string_literal: true

namespace :todos_reminders do
  desc 'reminders for todos'
  task reminders: :environment do
    @todos = Todo.where.not(remind_at: nil)
    @todos.find_each do |todo|
      time = todo.remind_at
      reminder_time = time.strftime('%I:%M%p')
      frequency = todo.reminder_frequency
      last_reminder = todo.last_reminder_sent_at
      if last_reminder.nil?
        TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo)
        todo.update(last_reminder_sent_at: DateTime.now)
      elsif frequency == 'daily'
        TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo) if last_reminder + 24.hours
      elsif frequency == 'weekly'
        TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo) if last_reminder + 7.days
      elsif frequency == 'biweekly'
        TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo) if last_reminder + 14.days
      elsif frequency == 'monthly'
        TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo) if last_reminder + 30.days
      end
    end
  end
end
