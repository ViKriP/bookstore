require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do

  describe 'GET #show' do
    it do
      get :show, params: { id: :checkout }
    end
  end
end
