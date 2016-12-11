class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_authenticity, if: :request_from_client?

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

  private
    def request_from_client?
      !params[:client_id].nil?
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
end
