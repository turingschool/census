class Api::V1::UsersController < Api::V1::ApiController
  before_action :doorkeeper_authorize!

  def index
    render(
      json: User
        .order(created_at: :desc)
        .includes(:roles, :groups)
        .limit(params[:limit] || 100)
        .offset(params[:offset] || 0),
      root_url: root_url,
      status: 200
    )
  end

  def show
    @user = User.with_serializer_info.find(params[:id])
    render json: @user, serializer: SingleUserSerializer, root_url: root_url, status: 200
  end

end
