require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cafeteria
  class Application < Rails::Application
    config.load_defaults 7.1
    config.i18n.default_locale = :pt_br
    config.time_zone = "America/Sao_Paulo"
    config.generators.system_tests = nil

    ArLazyPreload.config.auto_preload = true

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: ["assets", "tasks"])

    Stripe.api_key = Rails.application.credentials.stripe&.api_key

    Groupdate.register_adapter "litedb", Groupdate::Adapters::SQLiteAdapter
    Groupdate.time_zone = "UTC"

    Chartkick.options = {
      thousands: I18n.t("number.format.separator"),
      decimal: I18n.t("number.format.delimiter")
    }
  end
end
