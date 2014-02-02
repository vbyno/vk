class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :manage, :all if user.try(:admin?)
  end
end
