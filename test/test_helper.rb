$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require "#{File.dirname(__FILE__)}/../lib/role"
require "#{File.dirname(__FILE__)}/../lib/active_record/aggregations/has_roles"

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config['sqlite3_memory'])
load(File.dirname(__FILE__) + "/schema.rb")
Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures"
$LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path)

ActiveRecord::Base.send(:include, ActiveRecord::Aggregations::HasRoles)

require 'action_filters'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, %w(roles users privileges))
end

require 'test/models/user'