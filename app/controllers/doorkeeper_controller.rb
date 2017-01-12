# This controller is designed to overide Doorkeeper's default behavior.
# when a user makes a request to the sessions_controller, check if
# the request came from a client application. If the request came from a
# client, as would be the case if the request ontained a client id param,
# check that the client is authentic by finding the application from the
# client id. If the request is authentic, store the fullpath of the request
# in the users session so that the sessions_controller can redirect the user
# to that path upon successful authentication, thereby overiding the default
# behavior
class DoorkeeperController < ApplicationController
  before_action :check_authenticity, if: :client_request?

  private
    def client_request?
      !params[:client_id].nil?
    end

    def check_authenticity
      if authentic_client_id?
        store_request_fullpath
      else
        head :forbidden
      end
    end

    def store_request_fullpath
      session[:return_path] = request.fullpath
    end

    def authentic_client_id?
      Doorkeeper::Application.by_uid(params[:client_id])
    end
end
