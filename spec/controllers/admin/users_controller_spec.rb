require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  let(:user) { create(:user) }
  before { sign_in admin_user }

  describe 'GET index' do
    it "should render the expected columns" do
      user.save
      get :index
      expect(page).to have_content('Email')
      expect(page).to have_content('First Name')
      expect(page).to have_content('Last Name')
      expect(page).to have_content('Provider')
      expect(page).to have_content('Uid')
    end
  end

  describe "GET new" do
    it "should render the form elements" do
      get :new
      expect(page).to have_field('First name*')
      expect(page).to have_field('Last name*')
      expect(page).to have_field('Email*')
      expect(page).to have_field('Password*')
      expect(page).to have_field('Password confirmation')
    end
  end
end
