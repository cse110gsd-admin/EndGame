class CreateWorkouts < ActiveRecord::Migration
  def self.up
    create_table :workouts do |t|
      t.string :name
      t.string :description
      t.integer :entry_id
      t.integer :template_id
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :workouts
  end
end
