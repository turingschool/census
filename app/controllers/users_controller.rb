class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  authorize_resource

  def index
    @cohorts = Cohort.all
    if params[:cohort]
      cohort = Cohort.find(params[:cohort])
      @users = User.where(cohort: params[:cohort])
      @header = "Cohort: #{cohort.name}"
    else
      @users = User.all
      @header = "Users"
    end
  end

  def show
    if current_user.has_role?("admin")
      @user = User.find(params[:id])
    end
  end

  def edit
    if current_user.has_role?("admin")
      @user = User.find(params[:id])
    end
    @cohorts = Cohort.all
  end

  def update
    if current_user.has_role?("admin")
      @user = User.find(params[:id])
    end
    @user.skip_reconfirmation!
    if @user.update_attributes(user_params)
      flash[:success] = "Update was successful."
      redirect_to user_path(@user)
    else
      flash[:danger] = @user.errors.full_messages.join(". ")
      @cohorts = Cohort.all
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
                                    :cohort_id,
                                    :image )
    end

    def set_user
      @user = current_user
    end
end
