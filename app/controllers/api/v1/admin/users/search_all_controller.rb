class Api::V1::Admin::Users::SearchAllController < Api::V1::ApiController
  skip_before_action :doorkeeper_authorize!, only: [:index]
  before_action :require_admin

  def index
    users = User.search_all(params["q"])
    render json: users
  end

  def require_admin
    current_user && current_user.has_role?("admin") || doorkeeper_authorize!
  end
end
