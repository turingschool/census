class Permission
  def initialize(user)
    @user ||= User.new
  end

  def authorized?(user, controller, action)
    if user && user.has_role?("admin")
      return true if controller == "invitations" && action.in?(%w(new create update destroy index))
      return true if controller == "admin/dashboard" && action.in?(%w(show))
      return true if controller == 'users' && action.in?(%w(index show edit update))
      return true if controller == 'home' && action.in?(%w(index))
      return true if controller == 'affiliations' && action.in?(%w(create new))
      return true if controller == "devise/sessions" && action.in?(%w(create destroy))
      return true if controller == "devise/confirmations" && action.in?(%w(show))
      return true if controller == "doorkeeper/authorizations" && action.in?(%w(new create))
      return true if controller == "doorkeeper/applications" && action.in?(%w(new create index show edit update destroy))
      return true if controller == 'oauth/applications' && action.in?(%w(new create show index destroy edit update))
      return true if controller == 'users/sessions' && action.in?(%w(create destroy))
      return true if controller == 'doorkeeper/authorized_applications' && action.in?(%w(index destroy))
      return true if controller == 'users/registrations' && action.in?(%w(edit update))
    elsif user
      return true if controller == "users" && action.in?(%w(index show edit update))
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "affiliations" && action.in?(%w(create new))
      return true if controller == "devise/sessions" && action.in?(%w(create destroy))
      return true if controller == "devise/confirmations" && action.in?(%w(show))
      return true if controller == "doorkeeper/authorizations" && action.in?(%w(new create))
      return true if controller == "doorkeeper/applications" && action.in?(%w(new create index show edit update destroy))
      return true if controller == 'oauth/applications' && action.in?(%w(new create show index destroy edit update))
      return true if controller == "users/sessions" && action.in?(%w(create destroy))
      return true if controller == 'doorkeeper/authorized_applications' && action.in?(%w(index destroy))
      return true if controller == 'users/registrations' && action.in?(%w(edit update))
      false
    else
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "devise/sessions" && action.in?(%w(new))
      return true if controller == "devise/confirmations" && action.in?(%w(show))
      return true if controller == "users/registrations" && action.in?(%w(new create))
      return true if controller == "doorkeeper/authorizations" && action.in?(%w(new))
      return true if controller == "users/sessions" && action.in?(%w(new create))
    end
      print_warning(user, controller, action)
      false
  end

  def print_warning(user, controller, action)
    unless ENV["RAILS_ENV"] == "production"
      print "\n🚨 CHECK PERMISSIONS! Current User: #{!!user} – Controller: #{controller} – Action: #{action}\n"
    end
  end
end
