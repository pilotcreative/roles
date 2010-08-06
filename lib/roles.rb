require "role"
require "active_support/concern"
require "action_controller/require_role"

module Roles
  extend ActiveSupport::Concern

  included do
    if Role.table_exists?
      has_and_belongs_to_many :roles, :join_table => :privileges, :uniq => true

      Role.all.each do |role|
        scope role.to_s.pluralize.to_sym, :include => :roles, :conditions => ["roles.id = ?", role.id]
      end
    end
  end

  module ClassMethods
    def roles
      Role.all
    end
  end

  module InstanceMethods
    def is?(*roles)
      return true if self.roles.include?(Role[:administrator])
      roles.flatten.any? { |name| self.roles.include?(Role[name]) }
    end

    def is_not?(*roles)
      not is?(*roles)
    end
  end
end
