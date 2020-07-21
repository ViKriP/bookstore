class HomepageController < ApplicationController
  def index
    @presenter = HomepagePresenter.new
  end
end
