class Api::V1::SearchAllController < Api::V1::ApiController
  ROLES = ["applicant", "invited", "enrolled", "active student", "on leave",
          "graduated", "exited", "removed", "mentor", "admin"]

  def index
    if params["q"].count("0-9") > 0
      cohort = Cohort.find_by(name: params[:q])
      users = cohort.users
    elsif ROLES.include?(params["q"])
      roles = Role.find_by(name: params[:q])
      users = roles.users
    end
    render json: users
  end

end
