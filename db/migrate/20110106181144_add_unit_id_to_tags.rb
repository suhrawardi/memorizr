class AddUnitIdToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :unit_id, :int
  end

  def self.down
    remove_column :tags, :unit_id
  end
end
