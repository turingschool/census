class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
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
  end

  def edit
  end

  def update
    @user.skip_reconfirmation!
    if @user.update_attributes(user_params)
      flash[:notice] = "Update was successful."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit( :first_name,
                                    :last_name,
                                    :email,
                                    :twitter,
                                    :linked_in,
                                    :git_hub,
                                    :slack,
                                    :cohort )
    end

    def set_user
      @user = current_user
    end
end
