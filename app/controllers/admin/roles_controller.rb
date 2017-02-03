class Admin::RolesController < ApplicationController

  def index
    @roles = Role.all
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      flash[:success] = "#{@role.name} successfully created."
    else
      flash[:danger] = "Your new Role was not saved."
    end
    redirect_to admin_roles_path
  end


  private
    def role_params
      params.require(:role).permit(:name)
    end
end
