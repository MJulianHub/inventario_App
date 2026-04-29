require_relative "boot"

require "rails/all"
Bundler.require(*Rails.groups)

module InventarioApp
  class Application < Rails::Application
    config.load_defaults 8.1
    config.i18n.available_locales = [ :en, :es ]
    config.i18n.default_locale = :es
    config.time_zone = "Central America"
    config.active_record.default_timezone = :local
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
