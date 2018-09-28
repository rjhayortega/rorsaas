# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w( propertyshowcase.js )
Rails.application.config.assets.precompile += %w( 

  propertyshowcase.css 

)
# Rails.application.config.assets.precompile += %w( *.js *.css *.sass *.scss )


Rails.application.config.assets.precompile += Dir.glob(Rails.root.join('vendor', 'assets', 'javascripts', 'ckeditor', '**', '*')).select{ |e| File.file? e }

Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')