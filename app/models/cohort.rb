class Cohort < ApplicationRecord
  validates :name, presence: true
  has_many :users

  def student_count
    users.count
  end
end
