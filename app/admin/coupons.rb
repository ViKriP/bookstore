ActiveAdmin.register Coupon do
  permit_params :code, :discount, :active

  index do
    selectable_column

    id_column
    column :code
    column :discount
    column :active

    actions
  end

  filter :code
  filter :discount
  filter :active

  form do |f|
    f.inputs do
      f.input :code
      f.input :discount
      f.input :active
    end
    f.actions
  end
end
