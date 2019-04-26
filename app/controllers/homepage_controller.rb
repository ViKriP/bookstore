class HomepageController < ApplicationController
  def index
    @homepage_index = Homepage::IndexPresenter.new
  end
end
