class AddressesPresenter
  def initialize(user)
    @user = user
  end

  def addresses
    @user.billing_address || @user.build_billing_address
    @user.shipping_address || @user.build_shipping_address
  end
end