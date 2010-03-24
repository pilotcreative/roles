ActiveRecord::Base.send(:include, ActiveRecord::Aggregations::HasRoles)
ActionController::Base.send(:extend, Roles::ActionFilters)
