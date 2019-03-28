require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookstore
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators.test_framework :rspec
    config.generators.fixture_replacement :factory_bot, dir: 'spec/factories'
    #config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
    #  "<div class=\"field_with_errors control-group has-error\">#{html_tag}</div>".html_safe
    #}
  end
end
