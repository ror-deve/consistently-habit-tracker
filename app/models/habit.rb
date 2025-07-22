class Habit < ApplicationRecord
  # associations
  belongs_to :user
  has_many :habit_checkins, dependent: :destroy
  has_many :habit_logs, dependent: :destroy

  # validations
  validates :name, presence: true

  def done_dates
    habit_logs.select(:done_on).distinct.pluck(:done_on).sort
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
    total_days = (Date.today - created_at.to_date).to_i + 1
    return 0 if total_days <= 0

    ((done_dates.count.to_f / total_days) * 100).round(2)
  end

  def done_dates_lookup
    @done_dates_lookup ||= habit_logs.pluck(:done_on).to_set
  end  
end
