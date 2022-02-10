# frozen_string_literal: true

class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  belongs_to :user
  enum reminder_frequency: { daily: 'daily', weekly: 'weekly', biweekly: 'biweekly', monthly: 'monthly' }

  scope :reminder_todos, -> { where.not(remind_at: nil) }

  def eligible_for_next_reminder?
    last_reminder = last_reminder_sent_at
    return false if completed_at.present?

    return true if last_reminder.present? && DateTime.now >= last_reminder

    case reminder_frequency
    when 'daily'
      one_day_passed?
    when 'weekly'
      one_week_passed?
    when 'biweekly'
      two_weeks_passed?
    when 'monthly'
      one_month_passed?
    end
  end

  def one_day_passed?
    last_reminder = last_reminder_sent_at
    return true if DateTime.now >= last_reminder + 24.hours
  end

  def one_week_passed?
    last_reminder = last_reminder_sent_at
    return true if DateTime.now >= last_reminder + 7.days
  end

  def two_weeks_passed?
    last_reminder = last_reminder_sent_at
    return true if DateTime.now >= last_reminder + 14.days
  end

  def one_month_passed?
    last_reminder = last_reminder_sent_at
    return true if DateTime.now >= last_reminder + 30.days
  end
end
