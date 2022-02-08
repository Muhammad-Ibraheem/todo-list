# frozen_string_literal: true

class TodoReminder
  def initialize(todo)
    @todo = todo
  end

  def self.todos_reminders
    @todos = Todo.where.not(remind_at: nil)
    @todos.find_each do |todo|
      time = todo.remind_at
      reminder_time = time.strftime('%I:%M%p')
      frequency = todo.reminder_frequency
      last_reminder = todo.last_reminder_sent_at
      if last_reminder.nil?
        TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo)
        todo.update(last_reminder_sent_at: DateTime.now)
      end
      case frequency
      when 'daily'
        if last_reminder + 24.hours <= DateTime.now
          binding
          TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo)
          todo.update(last_reminder_sent_at: DateTime.now)
        end
      when 'weekly'
        if last_reminder + 7.days <= DateTime.now
          TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo)
          todo.update(last_reminder_sent_at: DateTime.now)
        end
      when 'biweekly'
        if last_reminder + 14.days <= DateTime.now
          TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo)
          todo.update(last_reminder_sent_at: DateTime.now)
        end
      when 'monthly'
        if last_reminder + 30.days <= DateTime.now
          TodoRemindersJob.set(wait_until: reminder_time).perform_later(todo)
          todo.update(last_reminder_sent_at: DateTime.now)
        end
      end
    end
  end
end
