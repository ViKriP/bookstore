ActiveAdmin.register Author do
  permit_params :first_name, :last_name, :description

  index do
    selectable_column

    id_column
    column :first_name
    column :last_name
    column :description

    actions
  end

  filter :first_name
  filter :last_name
  filter :description

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :description
    end
    f.actions
  end
end
