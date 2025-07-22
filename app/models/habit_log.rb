class HabitLog < ApplicationRecord
  belongs_to :habit
  validates :done_on, uniqueness: { scope: :habit_id }
end
