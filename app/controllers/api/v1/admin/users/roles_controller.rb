module Api::V1::Admin
  class Users::RolesController < Api::V1::Admin::AdminController
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
end
