class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :status
      t.string :email
      t.string :invitation_code
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
