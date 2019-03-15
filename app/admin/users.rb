ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :password, :password_confirmation

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
