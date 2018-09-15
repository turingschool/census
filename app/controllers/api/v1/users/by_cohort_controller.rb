class Api::V1::Users::ByCohortController < Api::V1::ApiController
  before_action :doorkeeper_authorize!

  def index
    users = User.with_serializer_info.where(cohort_id: params[:cohort_id])

    render json: users, each_serializer: UserSerializer, root_url: root_url, status: 200
  end
end
