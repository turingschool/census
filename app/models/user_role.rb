class UserRole < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :role_id

  belongs_to :user
  belongs_to :role
end
