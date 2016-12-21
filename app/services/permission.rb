class Permission
  def initialize(user)
    @user ||= User.new
  end

  def authorized?(user, controller, action)
    if user && user.roles.include?(Role.find_by(name: "admin"))
      return true if controller == "invitations" && action.in?(%w(new create update destroy))
      return true if controller == "admin/dashboard" && action.in?(%w(show))
      return true if controller == 'users/sessions' && action.in?(%w(create destroy))
      return true if controller == 'home' && action.in?(%w(index))
      return true if controller == 'users' && action.in?(%w(index show edit update))
    elsif user
      return true if controller == "users" && action.in?(%w(index show edit update))
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "affiliations" && action.in?(%w(create new))
      return true if controller == "devise/sessions" && action.in?(%w(create destroy))
      return true if controller == "devise/confirmations" && action.in?(%w(show))
      return true if controller == "doorkeeper/authorizations" && action.in?(%w(new create))
      return true if controller == "doorkeeper/applications" && action.in?(%w(new create index show edit update destroy))
      return true if controller == "users/sessions" && action.in?(%w(create destroy))
      false
    else
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "devise/sessions" && action.in?(%w(new))
      return true if controller == "devise/confirmations" && action.in?(%w(show))
      return true if controller == "users/registrations" && action.in?(%w(new create))
      return true if controller == "doorkeeper/authorizations" && action.in?(%w(new))
      return true if controller == "users/sessions" && action.in?(%w(new create))
      # TODO: This permission is temporary. Add requirement later.
      return true if controller == "api/v1/users" && action.in?(%w(index))
    end
      print_warning(user, controller, action)
      false
  end

  def print_warning(user, controller, action)
    unless ENV["RAILS_ENV"] == "production"
      puts "**********\nCHECK PERMISSIONS\nCurrent User: #{!!user}\nController: #{controller}\nAction: #{action}\n**********"
    end
  end
end
