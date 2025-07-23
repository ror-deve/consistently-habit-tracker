class Habit < ApplicationRecord
  # associations
  belongs_to :user
  has_many :habit_checkins, dependent: :destroy
  has_many :habit_logs, dependent: :destroy

  # validations
  validates :name, presence: true

  def done_dates
    @done_dates ||= habit_logs.pluck(:done_on).uniq.sort
  end

  def current_streak
    streak = 0
    date = Date.today

    done_dates.reverse.each do |done_date|
      break if done_date != date
      streak += 1
      date -= 1
    end

    streak
  end

  def longest_streak
    streak = 0
    max_streak = 0
    previous_date = nil

    done_dates.each do |date|
      if previous_date && date == previous_date + 1
        streak += 1
      else
        streak = 1
      end
      max_streak = [max_streak, streak].max
      previous_date = date
    end

    max_streak
  end

  def consistency_percentage
    return 0 if done_dates.empty?

    start_date = done_dates.min
    total_days = (Date.today - start_date).to_i + 1

    completed_days = done_dates.count
    percentage = (completed_days.to_f / total_days) * 100
    [percentage.round(2), 100.0].min
  end

  def done_dates_lookup
    @done_dates_lookup ||= habit_logs.pluck(:done_on).to_set
  end  
end
