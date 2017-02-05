class Group < ApplicationRecord
  has_many :affiliations, dependent: :destroy
  has_many :users, through: :affiliations

  def member_count
    users.count
  end
end
