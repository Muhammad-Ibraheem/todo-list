# frozen_string_literal: true

class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  belongs_to :user
  enum reminder_frequency: { daily: 'daily', weekly: 'weekly', biweekly: 'biweekly', monthly: 'monthly' }
end
