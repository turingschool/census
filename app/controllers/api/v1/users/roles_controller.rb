class Api::V1::Users::RolesController < Api::V1::ApiController
  skip_before_action :doorkeeper_authorize!, only: [:add, :remove]
  before_action :require_user_or_doorkeeper_authorize!

  def add
    roles = Role.find(params[:roles])
    users = User.find(params[:users])
    users.each do |user|
      roles.each {|role| user.roles << role }
    end
    render json: users
  end

  def remove
    roles = Role.find(params[:roles])
    users = User.find(params[:users])
    users.each do |user|
      roles.each {|role| user.roles.delete(role) }
    end
    render json: users
  end

end
