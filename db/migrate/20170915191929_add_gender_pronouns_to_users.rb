class AddGenderPronounsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gender_pronouns, :string
  end
end
