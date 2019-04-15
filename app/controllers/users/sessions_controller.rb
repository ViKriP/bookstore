module Users
  class SessionsController < Devise::SessionsController
    after_action :add_user_to_order, only: :create
  end
end