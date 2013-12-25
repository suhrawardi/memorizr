class AddAttachmentToUnits < ActiveRecord::Migration
  def change
    add_column :units, :attachment, :string
  end
end
