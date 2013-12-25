class AddImageToUnit < ActiveRecord::Migration
  def change
    change_table :units do |t|
      t.has_attached_file :image
    end
  end
end
