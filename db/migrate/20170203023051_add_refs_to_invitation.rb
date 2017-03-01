class AddRefsToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_reference :invitations, :cohort, foreign_key: true
  end
end
