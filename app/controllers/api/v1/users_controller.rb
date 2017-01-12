class Api::V1::UsersController < Api::V1::ApiController
  # before_action :testing
  before_action :doorkeeper_authorize!

  def index
    render json: User.all, root_url: root_url, status: 200
  end
  #
  # def testing
  #   byebug
  # end
end
