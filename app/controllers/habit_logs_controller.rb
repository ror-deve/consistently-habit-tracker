class HabitLogsController < ApplicationController

  def create
    @habit = current_user.habits.find(params[:habit_id])
    done_date = params[:done_on].present? ? Date.parse(params[:done_on]) : Date.today

    @habit.habit_logs.find_or_create_by(done_on: done_date)

    respond_to do |format|
      format.html { redirect_to habits_path, notice: "Habit Marked as done!" }
      format.turbo_stream
    end
  end
end
