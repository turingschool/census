class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    user ||= User.new # guest user (not logged in)

    if user.has_role?("admin")
      can :manage, :all
    elsif user.has_role?("mentor") || user.has_role?("active student") || user.has_role?("enrolled")
      can :create, User
      can :update, User, id: user.id
      can :read, User
      can :read, Group
      can :read, Role
      can :read, Affiliation
      can :manage, Doorkeeper::Application, user_id: user.id
    elsif user.has_role?("exited") || user.has_role?("removed")
      cannot :manage, :all
    else
      cannot :manage, :all
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
