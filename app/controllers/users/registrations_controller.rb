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
        @user = User.new(email: invitation.email, cohort_id: invitation.cohort_id)
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
      invitation = Invitation.find_by(invitation_code: session[:invitation_code])
      @user.roles << invitation.role
      @user.skip_confirmation!

      if @user.save
        invitation.accepted!
        session[:invitation_code] = nil
        flash[:success] = 'You have succesfully signed up!'
        sign_in(resource_name, resource)

        if session[:return_path]
          redirect_to session[:return_path]
        else
          respond_with resource, location: after_sign_in_path_for(resource)
        end
      else
        flash[:danger] = @user.errors.full_messages.join(", ")
        redirect_to new_user_registration_path(invite_code: session[:invitation_code])
      end
    else
      super
    end
  end

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
                                    :password_confirmation,
                                    :image,
                                    :stackoverflow,
                                    :gender_pronouns
                                    )
    end

    def valid_invitation_code?
      invitation = invitation(session[:invitation_code])
      !!invitation && invitation.email == params[:user][:email]
    end
end
