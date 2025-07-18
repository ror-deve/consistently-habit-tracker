class HabitCheckin < ApplicationRecord
  belongs_to :habit

  # Validations
  validates :date, presence: true
  validates :date, uniqueness: { scope: :habit_id } 
end
