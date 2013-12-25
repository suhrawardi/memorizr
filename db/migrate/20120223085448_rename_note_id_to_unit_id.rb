class RenameNoteIdToUnitId < ActiveRecord::Migration
  def up
    add_column :comments, :unit_id, :int
    remove_column :comments, :note_id
  end

  def down
    add_column :comments, :note_id, :int
    remove_column :comments, :unit_id
  end
end
