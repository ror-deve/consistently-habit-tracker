class HabitsController < ApplicationController
  before_action :set_habit, only: [:edit, :update, :destroy, :show]

  def index
    @habits = current_user.habits.includes(:habit_logs)
  end

  def new
    @habit = current_user.habits.new
  end

  def create
    @habit = current_user.habits.new(habit_params)
    if @habit.save
      redirect_to habits_path, notice: "Habit created successfully!"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @habit.update(habit_params)
      redirect_to habits_path, notice: "Habit updated!"
    else
      render :edit
    end
  end

  def destroy
    @habit.destroy
    respond_to do |format|
      format.html { redirect_to habits_path, notice: "Habit deleted!" }
      format.turbo_stream
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :description)
  end
end
