class Oauth::ApplicationsController < Doorkeeper::ApplicationsController
  authorize_resource class: Doorkeeper::Application

  def index
    @applications = current_user.oauth_applications
  end

  # only needed if each application must have some owner
  def create
    @application = Doorkeeper::Application.new(application_params)
    @application.owner = current_user if Doorkeeper.configuration.confirm_application_owner?
    if @application.save
      flash[:success] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
      redirect_to oauth_application_url(@application)
    else
      flash[:danger] = @application.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def set_application
    if current_user
      @application = current_user.oauth_applications.find(params[:id])
    else
      render file: "/public/404", status: 404, layout: false
    end
  end

end
