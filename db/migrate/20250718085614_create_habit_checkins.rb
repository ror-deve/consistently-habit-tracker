class CreateHabitCheckins < ActiveRecord::Migration[7.2]
  def change
    create_table :habit_checkins do |t|
      t.references :habit, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
