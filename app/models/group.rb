class Group < ApplicationRecord
  has_many :affiliations, dependent: :destroy
end
