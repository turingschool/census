class Api::V1::Users::SearchAllController < Api::V1::ApiController
  skip_before_action :doorkeeper_authorize!, only: [:index]
  before_action :require_user_or_doorkeeper_authorize!

  def index
    users = User.search_all(params["q"])
    render json: users
  end

  private

  def require_user_or_doorkeeper_authorize!
    current_user || doorkeeper_authorize!
  end

end
