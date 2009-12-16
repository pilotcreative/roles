require 'test/unit'
require 'test/test_helper'

class RolesTest < Test::Unit::TestCase
  def test_user_have_acssoctiation_to_roles
    assert_equal 1, User.find_by_login("John").roles.size
  end
  
  def test_is_and_is_not
    # john.roles => :administrator
    john = User.find_by_login("John")
    assert john.is?(:administrator)
    assert john.is?(:uploader)
    
    # kate.roles => :moderator, :uploader
    kate = User.find_by_login("Kate")
    assert !kate.is_not?(:uploader)
    assert !kate.is_not?(:uploader, :moderator, :administrator)
    assert kate.is_not?(:editor)
    
    mary = User.find_by_login("Mary Jackson")
    assert mary.is_not?(:administrator, :moderator, :uploader)
  end
  
  def test_generated_methods
    john = User.find_by_login("John")
    
    assert john.respond_to?(:uploader?)
    assert john.administrator?
    assert john.uploader?
    
    kate = User.find_by_login("Kate")
    assert !kate.administrator?
    assert kate.moderator?
    assert kate.uploader?
    
    mary = User.find_by_login("Mary Jackson")
    assert mary.editor?
    assert !mary.administrator?
  end
  
  def test_find_with_role
    assert_equal 2, User.find_with_role(:moderator, :uploader, :administrator).size
  end
  
  def test_role_should_have_association_to_user
    assert_equal 1, Role[:administrator].users.size
    assert_equal 1, Role[:editor].users.size
  end
  
  def test_find_role_by_name
    assert_equal Role.find_by_name("administrator"), Role[:administrator]
  end
end
