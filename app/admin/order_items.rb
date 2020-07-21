ActiveAdmin.register OrderItem do
  actions :index, :show

  index do
    selectable_column

    id_column
    column :quantity
    column :order
    column :book

    actions
  end

  filter :quantity
  filter :order
  filter :book
end
