class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stackoverflow, :string
  end
end
