require File.dirname(__FILE__) + '/test_helper'

class RoleTest < ActiveSupport::TestCase
  context "Role" do
    setup do
      #sham.reset doesn't work
      @admin = Role.find_by_name('administrator')
      @moderator = Role.find_by_name('moderator')
      @uploader = Role.find_by_name('uploader')
      @editor = Role.find_by_name('editor')
      @john = User.find_by_login('John') || User.make(:login => 'John')
      @kate = User.find_by_login('Kate') || User.make(:login => 'Kate')
    end
    context "Role model" do
      setup do
        @john.roles << @admin
        @kate.roles = [@moderator, @uploader]
      end
      subject {@admin}
      
      should_validate_presence_of :name
      should_validate_uniqueness_of :name
      
      should "find_by_name method" do
        Role.find_by_name("administrator").should == Role[:administrator]
      end

      should "role has association to user" do
        Role[:administrator].users.size.should == 1
        Role[:moderator].users.size.should == 1
        Role[:uploader].users.size.should == 1
        Role[:editor].users.size.should == 0
      end

      should "check to_s method" do
        @admin.to_s.should == @admin.name
        @admin.to_s.should == "administrator"
      end
   end
  end
end
