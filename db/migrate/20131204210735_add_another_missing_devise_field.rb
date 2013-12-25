class AddAnotherMissingDeviseField < ActiveRecord::Migration
  def up
    add_column :users, :invitation_sent_at, :datetime
  end

  def down
    remove_column :users, :invitation_sent_at
  end
end
