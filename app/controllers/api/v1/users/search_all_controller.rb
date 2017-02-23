class Api::V1::Users::SearchAllController < Api::V1::ApiController

  def index
    users = User.search_all(params["q"])
    render json: users
  end

end
