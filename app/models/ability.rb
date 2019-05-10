class Ability
  include CanCan::Ability

  def initialize(user)
    guest

    registered(user) if user
  end

  def registered(user)
    can :manage, User, id: user.id
    can :create, Review, user_id: user.id
    can :manage, Order, user_id: user.id
  end

  def guest
    can :read, Book
    can :read, Review
    can :manage, OrderItem
    can :read, :all
  end
end
