class HomepageController < ApplicationController
  before_action :authenticate_user!
end
