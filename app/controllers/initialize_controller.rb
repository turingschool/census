class InitializeController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.start_to_create(user_params)
    if user.save!
      # user.send_confirmation
    else
      # need to test for sad path
    end
  end

  private

    def user_params
       params[:user].permit(:first_name, :last_name, :email)
    end
end
