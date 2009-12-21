require File.dirname(__FILE__) + '/test_helper'

class UserTest < ActiveSupport::TestCase
  context "User" do
    setup do
      #sham.reset doesn't work
      @admin = Role.find_by_name('administrator') 
      @moderator = Role.find_by_name('moderator') 
      @uploader = Role.find_by_name('uploader') 
      @editor = Role.find_by_name('editor')
      @john = User.find_by_login('John') || User.make(:login => 'John')
      @kate = User.find_by_login('Kate') || User.make(:login => 'Kate')
    end

    context "User model" do
      setup do
        @john.roles << @admin
        @kate.roles = [@moderator, @uploader]
      end
      subject { @john }

      should_have_and_belong_to_many :roles

      should "user has roles" do
        @john.roles.count.should == 1
        @kate.roles.count.should == 2
      end

      should "is and is_not methods" do
        # john.roles => :administrator
        @john.is?(:administrator).should == true
        @john.is?(:uploader).should == true
        @john.is_not?(:editor).should == false

        # kate.roles => :moderator, :uploader
        @kate.is_not?(:uploader).should == false
        @kate.is_not?(:uploader, :moderator, :administrator).should == false
        @kate.is_not?(:editor).should == true
        @kate.is?(:uploader).should == true
      end

      should "generating methods" do
        @john.respond_to?(:administrator?).should == true
        @john.administrator?.should == true
        @john.uploader?.should == true

        @kate.administrator?.should_not == true
        @kate.moderator?.should == true
        @kate.uploader?.should == true
      end

      should "find_with_role method" do
        User.find_with_role(:moderator, :uploader, :administrator).size.should == 2
        User.find_with_role(:moderator).size.should == 1
      end
    end
  end
end
