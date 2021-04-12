require_relative 'boot'
require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TaskApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'

    # メンテナンスバッチ処理
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    
    #field_with_errors」によるレイアウト崩れを防ぐ
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    config.generators do |g|
    g.test_framework :rspec,
      fixtures: false,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end
  end
end
