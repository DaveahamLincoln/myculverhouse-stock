source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  #gem 'compass-rails'

  #Foundation CSS Layout
  #gem 'zurb-foundation'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'passenger'

gem 'bcrypt-ruby', '~> 3.0.0'

gem 'simple_form'

gem 'strong_parameters'

gem 'watu_table_builder', :require => "table_builder"

gem "seed_dump", "~> 0.5.3"

#gem 'paperclip', "~>3.0"

gem 'rmagick', '2.13.2'

#Official Release
gem 'comfortable_mexican_sofa', '~>1.8.0'

#QR Code generator
gem 'rqrcode'

gem 'rufus-scheduler'

#Forge
#no idea why this doesn't work when the gem is at vendor/plugins/comfy
#gem 'comfortable_mexican_sofa', '~>1.8.0', :path => "vendor/plugins/comfy"

#mixable_engines allows you to extend engines by writing plugins and placing them in the app tree, rather than having to shatter and rebuild the gem.
#Example- I want to add a method to the sites_controller of comfortable-mexican-sofa, which is located at
#/comfortable-mexican-sofa
#    /app
#        /controllers
#            /cms_admin
#                /sites_controller.rb
#
#I create a /cms admin folder under the_app_I_want_to_extend/app/controllers, and put a sites_controller.rb file inside.
#E.g.
#
#/myculverhouse_stock
#    /app
#        /controllers
#            /cms_admin
#                /sites_controller.rb
#
#Then I copy the class declaration, in this case 
#
#class CmsAdmin::SitesController < CmsAdmin::BaseController
#
#into the new file.  Then I add whatever it is I want to add, like so:
#
#class CmsAdmin::SitesController < CmsAdmin::BaseController
#    def foo
#        return bar
#    end
#end
#
#Now I can call Cms::Site.foo
gem 'mixable_engines'

#Mountable blog engine.
gem 'monologue'