class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_filter :store_current_location, :unless => :devise_controller?
  before_action :check_authenticity, if: :request_from_client?
  #
  def request_from_client?
    !params[:client_id].nil? # and it is a valid id
    # if it's not from a client
    # is there a session record of the redirect uri
    # and if so, delete it.
  end

  def check_authenticity
    if authentic_client_id?
      store_current_location
    else
      head :forbidden
    end
  end

  def store_current_location
    session[:return_path] = request.fullpath
  end

  def authentic_client_id?
    Doorkeeper::Application.by_uid(params[:client_id])
  end

 #  def after_sign_in_path_for(resource)
 #    stored_location_for(resource) ||
 #    if resource.is_a?(User) && resource.can_publish?
 #       publisher_url
 #     else
 #       super
 #     end
 # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name,
                                                        :last_name,
                                                        :twitter,
                                                        :linked_in,
                                                        :git_hub,
                                                        :slack,
                                                        :cohort ])
  end
end
