ActiveAdmin.register Coupon do
  permit_params :code, :discount, :active
end
