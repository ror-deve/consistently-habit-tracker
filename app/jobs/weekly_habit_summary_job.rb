class WeeklyHabitSummaryJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      HabitSummaryMailer.weekly_summary(user).deliver_later
    end
  end
end
