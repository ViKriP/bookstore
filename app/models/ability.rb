class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    guest
    registered if user
  end

  def registered
    can :manage, User, id: @user.id
    can :create, Review, user_id: @user.id
  end

  def guest
    can :read, Book
    can :read, Review
    can :manage, OrderItem
    can :read, :all
  end
end
