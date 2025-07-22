class HabitSummaryMailer < ApplicationMailer
  default from: 'test@reelon.com'

  def weekly_summary(user)
    @user = user
    @habits = user.habits.includes(:habit_checkins)
    mail(to: @user.email, subject: "Your Weekly Habit Summary")
  end
end
