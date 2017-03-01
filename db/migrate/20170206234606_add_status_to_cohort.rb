class AddStatusToCohort < ActiveRecord::Migration[5.0]
  def change
    add_column :cohorts, :status, :integer, default: 0
  end
end
