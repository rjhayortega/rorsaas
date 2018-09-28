require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HouseQ
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # config.active_job.queue_adapter = :delayed_job
    config.active_job.queue_adapter = :sidekiq
    config.assets.initialize_on_precompile=false
    
    config.generators do |g|
      g.stylesheet_engine :sass
    end
    # config.time_zone = "Adelaide"

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :delete, :patch]
      end
    end
  end
end
