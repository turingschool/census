require 'forwardable'

class Cohort
  extend Forwardable
  def_delegators :@raw_cohort, :id, :start_date, :name, :status

  def initialize(cohort)
    @raw_cohort = cohort
  end

  def as_json(args=nil)
    {
      id: self.id,
      name: self.name,
      start_date: self.start_date,
      status: self.status
    }
  end

  def self.all
    result = Enroll::Client.query(CohortsQuery)
    result.data.cohorts.map { |cohort| Cohort.new(cohort) }
  end

  def self.search_by_name(query)
    self.all.select { |cohort| cohort.name.upcase.include?(query.first.gsub("%", "").upcase) }
  end

  def self.find(id)
    all.find { |cohort| cohort.id == id.to_i }
  end

  def self.find_by_name(name)
    all.find { |cohort| cohort.name == name }
  end

  def student_count
    users.count
  end

  def users
    @cohort_users ||= User.where(cohort_id: @raw_cohort.id)
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
    {
      "open" => Role.find_by(name:"active student"),
      "closed" => Role.find_by(name:"graduated")
    }
  end
end
