$:.unshift(File.dirname(__FILE__) + '/../lib')

ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/config/environment")

require 'test/unit'
require 'rubygems'
require 'active_record'
require 'active_support'
require "#{File.dirname(__FILE__)}/../lib/role"
require "#{File.dirname(__FILE__)}/../lib/active_record/aggregations/has_roles"

load(File.dirname(__FILE__) + "/schema.rb")

ActiveRecord::Base.send(:include, ActiveRecord::Aggregations::HasRoles)

require 'action_filters'
require 'test/models/user'

require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require 'mocha'
require 'shoulda'
require 'matchy'

class ActiveSupport::TestCase
  setup { Sham.reset }
end

