class Api::V1::SearchAllController < Api::V1::ApiController
  ROLES = ["applicant", "invited", "enrolled", "active student", "on leave",
          "graduated", "exited", "removed", "mentor", "admin"]

  def index
    if params["q"].count("0-9") > 0
      cohort = Cohort.find_by(name: params[:q])
      users = cohort.users
    elsif ROLES.include?(params["q"])
      role = Role.find_by(name: params[:q])
      users = role.users
    elsif groups.include?(params["q"])
      group = Group.find_by(name: params[:q])
      users = group.users
    else
      users = User.where(first_name: params["q"])
      users = users + User.where(last_name: params["q"])
    end
    render json: users
  end

  private

  def groups
    Group.all.map do |group|
      group.name
    end
  end

end
