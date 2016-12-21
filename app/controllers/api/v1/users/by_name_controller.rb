class Api::V1::Users::ByNameController < ApplicationController
  def index
    users = User.search_by_name(params[:q])

    users_data = users.map do |user|
      {
        "first_name"=>user.first_name,
        "last_name"=>user.last_name,
        "cohort"=>user.cohort,
        "image_url"=>user.image.url
      }
    end

    render json: users_data, status: 200
  end
end
