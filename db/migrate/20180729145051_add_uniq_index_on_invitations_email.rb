class AddUniqIndexOnInvitationsEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :invitations, :email, unique: true
  end
end
