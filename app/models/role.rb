class Role < ApplicationRecord
  ENROLL_ELLIGIBLE_ROLE_NAME = "enroll-elligible"

  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  def member_count
    users.count
  end
end
