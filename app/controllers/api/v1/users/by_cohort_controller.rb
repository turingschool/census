class Api::V1::Users::ByCohortController < Api::V1::ApiController
  before_action :doorkeeper_authorize!

  def index
    cohort = Cohort.find(params[:cohort_id])
    users = cohort.users

    render json: users, each_serializer: UserSerializer, root_url: root_url, status: 200
  end
end
