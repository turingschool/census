class AddNameToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :name, :string
  end
end
