class AddMissingDeviseFields < ActiveRecord::Migration
  def up
    add_column :users, :invited_by_id, :int
    add_column :users, :invited_by_type, :string
  end

  def down
    remove_column :users, :invited_by_type
    remove_column :users, :invited_by_id
  end
end
