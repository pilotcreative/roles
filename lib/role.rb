class Role < ActiveRecord::Base
  validate :name, :presence => true, :uniqueness => true

  def self.[](name)
    where(:name => name.to_s).first
  end

  def to_s; name end
end