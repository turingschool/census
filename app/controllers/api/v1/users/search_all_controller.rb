class Api::V1::Users::SearchAllController < Api::V1::ApiController
  ROLES = ["applicant", "invited", "enrolled", "active student", "on leave",
          "graduated", "exited", "removed", "mentor", "admin"]

  def index
    users = User.search_all(params["q"])
    render json: users
  end

end
