ActiveAdmin.register Delivery do
  permit_params :name, :min_term, :max_term, :price
end