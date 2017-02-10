class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @cohorts = Cohort.all
    if params[:invite_code]
      invite_code = params[:invite_code]
      invitation = invitation(invite_code)
      if invitation
        @user = User.new(email: invitation.email, cohort: invitation.cohort)
        @user.skip_confirmation!
        session[:invitation_code] = invitation.invitation_code
        render :new
      else
        render file: "/public/404", status: 404, layout: false
      end
    else
      render file: "/public/404", status: 404, layout: false
    end
  end

  # POST /resource
  def create
    if valid_invitation_code?
      @user = User.new(invited_user_params)
      @user.roles << invitation(session[:invitation_code]).role
      @user.skip_confirmation!
      if @user.save
        session[:invitation_code] = nil
        flash[:success] = 'You have succesfully signed up! Please log in to continue.'
        redirect_to new_user_session_path
      else
        flash[:danger] = @user.errors.full_messages.join(", ")
        redirect_to new_user_registration_path(invite_code: session[:invitation_code])
      end
    else
      super
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

    def invitation(code)
      @invitation ||= Invitation.find_by(invitation_code: code)
    end
    def invited_user_params
      params.require(:user).permit(
        :email,
        :first_name,
        :last_name,
        :twitter,
        :linked_in,
        :git_hub,
        :slack,
        :cohort_id,
        :password,
        :password_confirmation
      )
    end

    def valid_invitation_code?
      invitation = invitation(session[:invitation_code])
      !!invitation && invitation.email == params[:user][:email]
    end
end
