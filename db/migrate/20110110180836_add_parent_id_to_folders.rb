class AddParentIdToFolders < ActiveRecord::Migration
  def self.up
    add_column :folders, :parent_id, :int
  end

  def self.down
    remove_column :folders, :parent_id
  end
end
