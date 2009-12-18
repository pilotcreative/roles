# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.gem "mhennemeyer-matchy", :lib => false, :source => "http://gems.github.com"
  config.gem "machinist", :lib => false

  config.action_controller.session = { :session_key => "_myapp_session", :secret => "6c1372e61789239a727cdbc8252eb6da" }
end
