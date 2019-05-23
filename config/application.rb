require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PokeTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # the public url base to request pokeapi
    config.api_url = 'http://pokeapi.co/api/v2/'
    # the public url base to serve the pokemon default image
    config.image_base = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/'
    # the public url base to serve the pokemon default back image
    config.image_back_base = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/'
  end
end
