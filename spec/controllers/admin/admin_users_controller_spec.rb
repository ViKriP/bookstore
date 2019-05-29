require 'rails_helper'

RSpec.describe Admin::AdminUsersController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  before { sign_in admin_user }

  describe "GET new" do
    it "should render the form elements" do
      get :new
      expect(page).to have_field('Email*')
      expect(page).to have_field('Password*')
      expect(page).to have_field('Password confirmation')
    end
  end

  describe 'GET index' do
    it "should render the expected columns" do
      get :index
      expect(page).to have_content('Id')
      expect(page).to have_content('Current Sign In At')
      expect(page).to have_content('Sign In Count')
      expect(page).to have_content('Created At')
    end
  end
end
