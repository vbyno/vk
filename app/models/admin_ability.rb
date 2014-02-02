class AdminAbility
  include CanCan::Ability

  def initialize(admin)
    return unless admin

    can :manage, :all
  end
end
