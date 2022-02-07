# frozen_string_literal: true

set :output, 'log/cron.log'
set :environment, 'development'

every 10.minutes do
  rake todos_reminders: reminders
end
