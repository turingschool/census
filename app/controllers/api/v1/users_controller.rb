class Api::V1::UsersController < ApplicationController
  def index
    users = User.all

    users = users.map do |user|
      {
        "first_name"=>user.first_name,
        "last_name"=>user.last_name,
        "cohort"=>user.cohort,
        "image_url"=>user.image.url
      }
    end

    render json: users
  end
end
