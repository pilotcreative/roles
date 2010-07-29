module Roles
  module ActionController
    module RequireRole
      def require_role(role, options = {})
        method = "_require_role_#{role}_#{Time.now.to_f.to_s.gsub('.', '')}"

        define_method method do
          raise Unauthorized unless send(:current_user) and send(:current_user).is?(:"#{role}")
        end

        before_filter method, options
      end
    end
  end

  class Unauthorized < Exception; end
end

ActionController::Base.send(:extend, Roles::ActionController::RequireRole)