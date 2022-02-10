# frozen_string_literal: true

class TodoReminderService
  def self.call
    @todos = Todo.reminder_todos.each do |todo|
      @todo = todo.remind_at
      if todo.eligible_for_next_reminder?
        TodoRemindersJob.set(wait_until: @todo).perform_later(todo)
        todo.update(last_reminder_sent_at: DateTime.now)
      end
    end
  end
end
