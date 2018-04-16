class Api::V1::Admin::RolesController < Api::V1::Admin::BaseController
  skip_before_action :doorkeeper_authorize!, only: [:update, :destroy]
  before_action :require_admin

  def update
    role = Role.find(params[:id])
    role.update_attributes(role_params)
    if role.save
      render json: role
    else
      render json: "ID does not exisit".to_json, status: 400
    end
  end

  def destroy
    role = Role.find(params[:id])
    if role.destroy
      render json: {id: role.id, message: "#{role.name} removed"}.to_json
    else
      render json: "Unable to delete #{role.name}.".to_json, status: 400
    end
  end

  private
    def role_params
      params.require(:role).permit(:name)
    end

end
