class Api::V1::Users::ByNameController < ApplicationController
  def index
    users = User.search_by_name(params[:q])

    render json: users, each_serializer: UserSerializer, status: 200
  end
end
