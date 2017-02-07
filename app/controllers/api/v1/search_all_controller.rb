class Api::V1::SearchAllController < Api::V1::ApiController
  def index
    if params["q"].count("0-9") > 0
      cohort = Cohort.find_by(name: params[:q])
      users = cohort.users
    end
    render json: users
  end

end
