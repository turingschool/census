class Api::V1::RolesController < Api::V1::ApiController
  before_action :doorkeeper_authorize!

  def update
    role = Role.find(params[:id])
    role.update_attributes(role_params)
    if role.save
      render json: role
    else
      render json: "Id does not exisit", status: 400
    end
  end

  private
    def role_params
      params.require(:role).permit(:name, :id)
    end

end
