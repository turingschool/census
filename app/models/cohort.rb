class Cohort < ApplicationRecord
  validates :name, presence: true
  has_many :users
  enum status: [:unstarted, :active, :finished]

  def student_count
    users.count
  end
end
