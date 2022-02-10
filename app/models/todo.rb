# frozen_string_literal: true

class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  belongs_to :user
  enum reminder_frequency: { daily: 'daily', weekly: 'weekly', biweekly: 'biweekly', monthly: 'monthly' }

  scope :reminder_todos, -> { where.not(remind_at: nil) }

  def eligible_for_next_reminder?
    return false if completed_at.present?

    return true if last_reminder_sent_at.present? && DateTime.now >= last_reminder_sent_at

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
    DateTime.now >= last_reminder_sent_at + 1.day
  end

  def one_week_passed?
    DateTime.now >= last_reminder_sent_at + 1.week
  end

  def two_weeks_passed?
    DateTime.now >= last_reminder_sent_at + 2.weeks
  end

  def one_month_passed?
    DateTime.now >= last_reminder_sent_at + 1.month
  end
end
