class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud

    case user.user_type
    when 'Premium Account'
      can :manage, Organisation, id: user.organisation_id
      can :manage, Office, organisation_id: user.organisation_id
      can :manage, User, organisation_id: user.organisation_id
      can :manage, Post
    when 'Office Account'
      can :crud, Office, id: user.office_id
      cannot :cap, Office
      can :manage, Post
      can :create, User
      can :hack_in, User, office_id: user.office_id
    when 'Agent Account'
      can :read, Office, id: user.office_id
      can :manage, Post
    when 'Trial Account'
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
