class AddPositionToUnits < ActiveRecord::Migration
  def self.up
    add_column :units, :position, :int
    add_column :units, :folder_id, :int
  end

  def self.down
    remove_column :units, :folder_id
    remove_column :units, :position
  end
end
