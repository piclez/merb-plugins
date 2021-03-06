if defined?(Merb::Plugins)
  Merb::Plugins.add_rakefiles "merb_rspec" / "merbtasks"
end

# Don't include anything for RSpec if we're not in the test environment
if Merb.environment == "test"
  require 'merb-test'
  
  require 'spec'
  require 'spec/rake/spectask' if $RAKE_ENV
  require 'spec/mocks'
  require 'spec/story'
  
  module Merb::Test::Rspec
  end
  
  require File.join(File.dirname(__FILE__) / 'matchers' / 'controller_matchers')
  require File.join(File.dirname(__FILE__) / 'matchers' / 'route_matchers')
  require File.join(File.dirname(__FILE__) / 'matchers' / 'view_matchers')
  
  Merb::BootLoader.after_app_loads do
    require File.join(File.dirname(__FILE__) / "merb_rspec" / "story")
  end
  
  Merb::Test::ControllerHelper.send(:include, Merb::Test::Rspec::ControllerMatchers)
  Merb::Test::RouteHelper.send(:include, Merb::Test::Rspec::RouteMatchers)
  Merb::Test::ViewHelper.send(:include, Merb::Test::Rspec::ViewMatchers)
end