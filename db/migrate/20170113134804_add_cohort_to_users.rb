class AddCohortToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :cohort, foreign_key: true
  end
end
