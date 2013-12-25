class AddDefaultFolderToUsers < ActiveRecord::Migration
  def self.up

    User.all.each do |user|
      unless user.selected_folder
        user.folders.create!(:name => 'inbox',
                             :description => 'This is your default folder')
      end
    end

    Unit.find_all_by_folder_id(nil).each do |unit|
      unit.update_attribute(:folder_id, unit.user.default_folder.id)
    end

  rescue
    puts $!
  end

  def self.down
    raise IrreversibleMigration
  end
end
