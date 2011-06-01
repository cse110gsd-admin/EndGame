class CreateExercises < ActiveRecord::Migration
  def self.up
    create_table :exercises do |t|
      t.string :name
      t.integer :reps
      t.integer :weight
      t.integer :exerciseable_id
      t.string  :exerciseable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :exercises
  end
end
