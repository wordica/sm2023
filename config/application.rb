require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Photoclicker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.time_zone = 'Warsaw'
    config.active_record.default_timezone = :local

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.assets.enabled = true
    config.encoding = "utf-8"

    config.i18n.default_locale = :pl
    config.i18n.locale = :pl
    config.autoload_paths += %W(#{config.root}/lib/devise)
    config.autoload_paths += %W(#{config.root}/lib/will_paginate)
  end
end
