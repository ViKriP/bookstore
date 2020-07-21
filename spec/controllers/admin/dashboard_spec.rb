require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  before { sign_in admin_user }

  describe "GET new" do
    it "should render the form elements" do
      get :index
      expect(page).to have_content(I18n.t('active_admin.dashboard_welcome.welcome'))
      expect(page).to have_content(I18n.t('active_admin.dashboard_welcome.call_to_action'))
      expect(page).to have_content('Authors count:')
      expect(page).to have_content('Categories count:')
      expect(page).to have_content('Books count:')
      expect(page).to have_content('Reviews count:')
      expect(page).to have_content('Users count:')
      expect(page).to have_content('Orders count:')
      expect(page).to have_content('Delivery type count:')
    end
  end
end
