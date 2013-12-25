class CreateUnits < ActiveRecord::Migration
  def self.up
    rename_table :notes, :units

    add_column :units, :type, :string
  end

  def self.down
    remove_column :units, :type

    rename_table :units, :notes
  end
end
