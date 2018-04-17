module Api::V1
  class Admin::AdminController < ApiController
    before_action do
      doorkeeper_authorize! :admin
    end
  end
end
