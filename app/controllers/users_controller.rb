class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  authorize_resource

  def index
    @presenter = UsersPresenter.new(params[:cohort])
  end

  def show
    find_user_if_admin || find_user_if_staff
  end

  def edit
    find_user_if_admin
    @cohorts = Cohort.all
  end

  def update
    find_user_if_admin
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
                                    :image,
                                    :stackoverflow )
    end

    def set_user
      @user = current_user
    end

    def find_user_if_admin
      @user = User.find(params[:id]) if current_user.has_role?("admin")
    end

    def find_user_if_staff
      @user = User.find(params[:id]) if current_user.has_role?("staff")
    end
end
