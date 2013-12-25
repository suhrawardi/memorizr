class RemovePaperclipFields < ActiveRecord::Migration
  def up
    remove_column :units, :image_file_name
    remove_column :units, :image_content_type
    remove_column :units, :image_file_size
    remove_column :units, :image_updated_at
  end

  def down
    add_column :units, :image_file_name, :string
    add_column :units, :image_content_type, :string
    add_column :units, :image_file_size, :integer
    add_column :units, :image_updated_at, :datetime
  end
end
