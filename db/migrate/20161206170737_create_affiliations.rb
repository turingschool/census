class CreateAffiliations < ActiveRecord::Migration[5.0]
  def change
    create_table :affiliations do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.timestamps null: false
    end
  end
end
