class AffiliationsController < ApplicationController
  authorize_resource

  def new
    @user = current_user
  end

  def create
    AffiliationManager.new(params[:user][:group_ids], current_user).run
    redirect_to user_path(current_user)
  end
end
