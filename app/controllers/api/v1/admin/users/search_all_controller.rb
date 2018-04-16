class Api::V1::Admin::Users::SearchAllController < Api::V1::Admin::BaseController
  skip_before_action :doorkeeper_authorize!, only: [:index]
  before_action :require_admin

  def index
    users = User.search_all(params["q"])
    render json: users
  end

end
