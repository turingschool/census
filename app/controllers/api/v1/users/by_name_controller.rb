class Api::V1::Users::ByNameController < ApplicationController
  def index
    search_term = params[:q].upcase

    users = User.where(
      "upper(first_name) LIKE ? OR
      upper(last_name) LIKE ?",
      "%#{search_term}%",
      "%#{search_term}%"
    )

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
