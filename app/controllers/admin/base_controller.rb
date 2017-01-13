class Admin::BaseController < ApplicationController
    authorize_resource class: Dashboard
end
