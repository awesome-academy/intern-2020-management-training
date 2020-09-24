class TrainerAbility
  include CanCan::Ability

  def initialize user
    can :manage, :all if user.role_trainer?
  end
end
