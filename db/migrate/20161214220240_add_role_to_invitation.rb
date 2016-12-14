class AddRoleToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_reference :invitations, :role, foreign_key: true
  end
end
