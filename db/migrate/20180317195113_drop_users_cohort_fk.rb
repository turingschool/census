class DropUsersCohortFk < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :users, :cohorts
    remove_foreign_key :invitations, :cohorts
  end
end
