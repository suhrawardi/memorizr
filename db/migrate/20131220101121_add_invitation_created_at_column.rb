class AddInvitationCreatedAtColumn < ActiveRecord::Migration
  def up
    add_column :users, :invitation_created_at, :datetime
  end

  def down
    remove_column :users, :invitation_created_at
  end
end
