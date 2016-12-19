class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authorize!

  protected

  def authorize!
    unless Permission.authorized?(current_user, params[:controller], params[:action])
#DEBUGGING ONLY
puts "**********
CHECK PERMISSIONS
Current User: #{!!current_user}
Controller: #{params[:controller]}
Action: #{params[:action]}
**********" unless ENV["RAILS_ENV"] == "production"
      render file: "/public/404", status: 404, layout: false
    end
  end

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
