class Api::V1::Users::ByGithubController < Api::V1::ApiController
  before_action :doorkeeper_authorize!

  def show
    if params[:q] && user = User.with_serializer_info.find_by(git_hub: params[:q])
      render json: user, serializer: UserSerializer, status: 200
    else
      render json: { error: "User not found" }, status: 404
    end
  end
end
