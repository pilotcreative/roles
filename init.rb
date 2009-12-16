require 'role'

if Role.table_exists?
  require 'action_filters'
  ActiveRecord::Base.send(:include, ActiveRecord::Aggregations::HasRoles)
  ActionController::Base.send(:extend, Roles::ActionFilters)
else
  ActiveRecord::Base.class_eval { def self.has_roles; end }
end
