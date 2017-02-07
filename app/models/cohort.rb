class Cohort < ApplicationRecord
  validates :name, presence: true
  has_many :users
  enum status: [:unstarted, :active, :finished]

  def student_count
    users.count
  end

  def update_student_roles(new_status)
    old_role = status_key[status]
    users.joins(:roles)
    .where(roles: {name: old_role.name})
    .each do |user|
      user.roles << status_key[new_status]
      user.roles.delete(old_role)
      user.save
    end
  end

  private

    def status_key
      { "unstarted" => Role.find_by(name:"enrolled"),
        "active" => Role.find_by(name:"active student"),
        "finished" => Role.find_by(name:"graduated") }
    end
end
