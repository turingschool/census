module Api::V1
  class ApiController < ActionController::API
    before_action :doorkeeper_authorize!

    # return json bodies for not found errors
    rescue_from ActiveRecord::RecordNotFound do |error|
      render json: { errors: ["Record Not Found"] }, status: 404
    end

    # return json bodies for doorkeeper authorization errors
    def doorkeeper_unauthorized_render_options(error: nil)
      { json: { errors: ["Not authorized"] } }
    end

    private

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def require_user_or_doorkeeper_authorize!
      current_user || doorkeeper_authorize!
    end
  end
end
