class AddCohortToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cohort, :string
  end
end
