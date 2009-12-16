module ActiveRecord
  module Aggregations
    module HasRoles
      def self.included(base)
        base.extend Macro
      end
      
      module Macro
        def has_roles(options = {})
          write_inheritable_attribute :privileges_table_name, options[:join_table] || "privileges"
          
          has_and_belongs_to_many :roles, :join_table => read_inheritable_attribute(:privileges_table_name), :uniq => true

          include InstanceMethods
          extend ClassMethods

          Role.all.each do |role|
            define_method("#{role}?") do
              is?(role.to_s) 
            end
          end
          
          Role.instance_eval <<-TXT
            has_and_belongs_to_many :#{class_name.downcase.pluralize}, :join_table => :#{read_inheritable_attribute(:privileges_table_name)}, :uniq => true
          TXT
        end
      end
      
      module ClassMethods
        def self.extended(base)
          Role.all.each do |role|
            base.named_scope role.to_s.pluralize.to_sym, :include => :roles, :conditions => ["roles.id = ?", role.id]
          end
        end
        
        def roles
          Role.all
        end
        
        def find_with_role(*role_names)
          find(:all, :include => :roles, :conditions => ["roles.name IN (?)", role_names.map(&:to_s)]).uniq
        end
      end
      
      module InstanceMethods
        # returns true 
        #  - when user has administrator role
        #  - when user has one of the supplied roles
        def is?(*role_names)
          roles = Rails.cache.fetch("/#{self.class.to_s.tableize}/#{id}/roles") { self.roles.map }
          return true if roles.include?(Role[:administrator])
          Array(role_names).any? { |name| roles.include?(Role[name]) }
        end
        
        def is_not?(*role_names)
          not is?(*role_names)
        end
      end
    end
  end
end