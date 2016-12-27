class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: User.all, root_url: root_url, status: 200
  end
end
