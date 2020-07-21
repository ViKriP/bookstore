ActiveAdmin.register Delivery do
  permit_params :name, :period, :price

  index do
    selectable_column

    id_column
    column :name
    column :period
    column :price

    actions
  end

  filter :name
  filter :period
  filter :price

  form do |f|
    f.inputs do
      f.input :name
      f.input :period
      f.input :price
    end
    f.actions
  end
end
