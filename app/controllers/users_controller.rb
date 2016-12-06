class UsersController < ApplicationController
  def index
    if params[:cohort]
      @users = User.where(cohort: params[:cohort])
      @header = "Cohort: #{params[:cohort]}"
    else
      @users = User.all;
      @header = "Users"
    end
  end

  def show
    @user = current_user
  end
end
