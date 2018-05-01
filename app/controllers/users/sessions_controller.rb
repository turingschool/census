class Users::SessionsController < Devise::SessionsController
  skip_authorize_resource
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:success, :signed_in)
    sign_in(resource_name, resource)
    if session[:return_path]
      redirect_to session[:return_path]
    else
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  # DELETE /resource/sign_out
  def destroy
    # super
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :success, :signed_out if signed_out
    respond_to_on_destroy
  end
end
