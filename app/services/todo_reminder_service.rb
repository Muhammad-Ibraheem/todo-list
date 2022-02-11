# frozen_string_literal: true

class TodoReminderService
  def self.call
    Todo.reminder_todos.each do |todo|
      if todo.eligible_for_next_reminder?
        TodoRemindersJob.set(wait_until: todo.remind_at).perform_later(todo)
        todo.update(last_reminder_sent_at: DateTime.now)
      end
    end
  end
end
