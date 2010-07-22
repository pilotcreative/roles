require "role"
require "active_record/aggregations/has_roles"

class ActionController::Base
  def self.require_role(role, options = {})
    method = "_require_role_#{role}_#{Time.now.to_i}"

    define_method method do
      raise Unauthorized unless send(:current_user) and send(:current_user).is?(:"#{role}")
    end

    before_filter method, options
  end

  class Unauthorized < Exception; end
end