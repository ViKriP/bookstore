class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :manage, User, id: user.id
    end
    can :read, Book
    can :read, :all
  end
end
