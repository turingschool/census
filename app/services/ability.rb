class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role?("admin")
      can :manage, :all
    elsif user.has_role?("mentor") || user.has_role?("active student") || user.has_role?("graduated") || user.has_role?("staff")
      can :create, User
      can :update, User, id: user.id
      can :read, User, id: user.id
      can :read, Cohort
      can :read, Group
      can :read, Role
      can :read, Affiliation
      can :create, Affiliation
      can :update, Affiliation
      can :manage, Doorkeeper::Application, owner_id: user.id
      cannot :manage, Invitation
    elsif user.has_role?("enrolled")
      can :create, User
      can :update, User, id: user.id
      can :read, User, id: user.id
      can :read, Cohort
      can :read, Group
      can :read, Role
      can :read, Affiliation
      can :create, Affiliation
      can :update, Affiliation
      cannot :manage, Invitation
    elsif user.has_role?("exited") || user.has_role?("removed")
      cannot :manage, :all
    else
      cannot :manage, :all
    end
  end
end
