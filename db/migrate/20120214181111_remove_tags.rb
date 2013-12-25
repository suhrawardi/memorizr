class RemoveTags < ActiveRecord::Migration
  def self.up
    drop_table :tags
  end

  def self.down
    create_table :tags do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
