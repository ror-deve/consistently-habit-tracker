class Habit < ApplicationRecord
  # associations
  belongs_to :user
  has_many :habit_checkins, dependent: :destroy

  # validations
  validates :name, presence: true
end
