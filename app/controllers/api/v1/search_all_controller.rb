class Api::V1::SearchAllController < Api::V1::ApiController
  ROLES = ["applicant", "invited", "enrolled", "active student", "on leave",
          "graduated", "exited", "removed", "mentor", "admin"]

  def index
    users = User.none
    cohorts = Cohort.where(
      "upper(name) LIKE ?",
      "%#{params["q"].upcase}%"
      )
    cohorts.each do |cohort|
      users += cohort.users
    end

    roles = Role.where(
      "upper(name) LIKE ?",
      "%#{params["q"].upcase}%"
      )

    roles.each do |role|
      users += role.users
    end

    groups = Group.where(
      "upper(name) LIKE ?",
      "%#{params["q"].upcase}%"
      )

    groups.each do |group|
      users += group.users
    end

    users += User.where(
      "upper(first_name) LIKE ? OR
      upper(last_name) LIKE ?",
      "%#{params["q"].upcase}%",
      "%#{params["q"].upcase}%"
      )

    render json: users
  end

end
