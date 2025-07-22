# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Clear existing data
HabitLog.destroy_all
Habit.destroy_all
User.destroy_all

# Create a test user
user = User.create!(
  email: "demo@reelon.com",
  password: "password123"
)

# Create some habits
habit1 = user.habits.create!(name: "Drink Water", description: "8 glasses a day")
habit2 = user.habits.create!(name: "Read Book", description: "30 minutes daily")

# Add logs
habit1.habit_logs.create!(done_on: Date.today)
habit1.habit_logs.create!(done_on: Date.today - 1)
habit2.habit_logs.create!(done_on: Date.today - 2)
