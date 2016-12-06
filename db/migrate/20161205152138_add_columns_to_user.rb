class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :twitter, :string
    add_column :users, :linked_in, :string
    add_column :users, :git_hub, :string
  end
end
