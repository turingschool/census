class Api::V1::Users::RolesController < Api::V1::ApiController

  def add
    roles = Role.find(params[:roles])
    users = User.find(params[:users])
    users.each do |user|
      roles.each {|role| user.roles << role }
    end
    render json: users
  end

  def remove
    require "pry"; binding.pry
  end

end
