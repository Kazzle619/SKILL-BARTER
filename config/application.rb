require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SKILLBarter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # デフォルトのlocaleを日本語(:ja)にする。
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml'.to_s)]

    # form_withでid, classが自動付与されていなかったので付けてみたが駄目。
    # form_withでidを付与しないようにするにはこれをfalseにしてくださいとrailsのgithubに書いてある。
    # https://github.com/rails/rails/commit/260d6f112a0ffdbe03e6f5051504cb441c1e94cd
    config.action_view.form_with_generates_ids = true
  end
end
