class Group < ApplicationRecord
  has_many :affiliations, dependent: :destroy
  has_many :users, through: :affiliations
end
