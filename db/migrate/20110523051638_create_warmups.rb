class CreateWarmups < ActiveRecord::Migration
  def self.up
    create_table :warmups do |t|
      t.string :description
      t.integer :entry_id
      t.integer :event_id


      t.timestamps
    end
  end

  def self.down
    drop_table :warmups
  end
end
