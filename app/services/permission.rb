class Permission
  def self.authorized?(user, controller, action)
    if user
      return true if controller == "users" && action.in?(%w(index show edit update))
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "affiliations" && action.in?(%w(create new))
      return true if controller == "devise/sessions" && action.in?(%w(create destroy))
      return true if controller == "doorkeeper/authorizations" && action.in?(%w(new))
      return true if controller == "doorkeeper/applications" && action.in?(%w(new create show))
      false
    else
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "devise/sessions" && action.in?(%w(new))
      return true if controller == "devise/registrations" && action.in?(%w(new create))
      return true if controller == "doorkeeper/authorizations" && action.in?(%w(new))
      false
    end
  end
end
