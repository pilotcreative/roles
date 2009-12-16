class Role < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
    
  def self.[](name)
    Rails.cache.fetch("/roles/#{name}") { find_by_name(name.to_s) }
  end

  def to_s; name; end
end