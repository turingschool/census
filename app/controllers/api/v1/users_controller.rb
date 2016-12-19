class Api::V1::UsersController < ApplicationController
  def index
    users_data = User.all.map do |user|
      {
        "first_name"=>user.first_name,
        "last_name"=>user.last_name,
        "cohort"=>user.cohort,
        "image_url"=>user.image.url
      }
    end

    render json: users_data
  end
end
