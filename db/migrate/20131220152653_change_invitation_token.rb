class ChangeInvitationToken < ActiveRecord::Migration
  def change
    change_column :users, :invitation_token, :string, :limit => 255
  end
end
