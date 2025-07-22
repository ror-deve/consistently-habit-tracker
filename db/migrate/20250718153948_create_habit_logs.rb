class CreateHabitLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :habit_logs do |t|
      t.references :habit, null: false, foreign_key: true
      t.date :done_on

      t.timestamps
    end
  end
end
