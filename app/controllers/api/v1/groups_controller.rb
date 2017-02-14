class Api::V1::GroupsController < Api::V1::ApiController

  def update
    group = Group.find(params[:id]) if Group.find(params[:id])
    group.update_attributes(group_params)
    if group.save
      render json: group
    else
      render json: "ID does not exisit".to_json, status: 400
    end
  end

  def destroy
    group = Group.find(params[:id])
    if group.destroy
      render json: group
    else
      render json: "Error deleting Group", status: 400
    end 
  end


  private
    def group_params
      params.require(:group).permit(:name)
    end

end
