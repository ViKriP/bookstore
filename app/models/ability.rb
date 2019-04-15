class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :manage, User, id: user.id
      can :create, Review
      can :manage, Order, user_id: user.id
    end
    can :read, Book
    can :read, Review
    can :manage, OrderItem
    can :read, :all
  end
end
