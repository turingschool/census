class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "#{@group.name} successfully created."
    else
      flash[:danger] = "Your new Group was not saved."
    end
    redirect_to admin_groups_path
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end


end
