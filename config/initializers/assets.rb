# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( panel/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( panel/font-awesome.min.css )
Rails.application.config.assets.precompile += %w( panel/ionicons.min.css )
Rails.application.config.assets.precompile += %w( panel/AdminLTE.css )

Rails.application.config.assets.precompile += %w( panel/morris/morris.css )
# Rails.application.config.assets.precompile += %w( panel/fullcalendar/fullcalendar.css )