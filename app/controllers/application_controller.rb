class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authorize!
  authorize_resource

  protected
  # def current_permission
  #   @current_permission ||= Permission.new(current_user)
  # end
  #
  # def authorize!
  #   unless authorized?
  #     render file: "/public/404", status: 404, layout: false
  #   end
  # end
  #
  # def authorized?
  #   current_permission.authorized?(current_user,
  #                                  params[:controller],
  #                                  params[:action])
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name,
                                                        :last_name,
                                                        :twitter,
                                                        :linked_in,
                                                        :git_hub,
                                                        :slack,
                                                        :cohort,
                                                        :image ])
  end
end
