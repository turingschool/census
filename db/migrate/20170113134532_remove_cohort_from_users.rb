class RemoveCohortFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :cohort, :string
  end
end
