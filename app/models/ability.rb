class Ability
  include CanCan::Ability
  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, User
      can :manage, Category
      can :manage, Word
    else
      can :read, User
      can :read, Category
      can :read, Word
    end
  end
end
