require File.dirname(__FILE__) + '/test_helper'

class UserTest < ActiveSupport::TestCase
  context "User model" do
    setup do
      #sham.reset doesn't work
      @admin = Role.find_by_name('administrator') ? Role.find_by_name('administrator') : Role.make(:name => 'administrator')
      @moderator = Role.find_by_name('moderator') ? Role.find_by_name('moderator') : Role.make(:name => 'moderator')
      @uploader = Role.find_by_name('uploader') ? Role.find_by_name('uploader') : Role.make(:name => 'uploader')
      @editor = Role.find_by_name('editor') ? Role.find_by_name('editor') : Role.make(:name => 'editor')
      @john = User.find_by_login('John') ? User.find_by_login('John') : User.make(:login => 'John')
      @kate = User.find_by_login('Kate') ? User.find_by_login('Kate') : User.make(:login => 'Kate')
    end

    context "User" do
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
        #@john.respond_to?(:administrator?).should == true
        #@john.administrator?.should == true
        #@john.uploader?.should == false

        #kate = User.find_by_login("Kate")
        #assert !kate.administrator?
        #assert kate.moderator?
        #assert kate.uploader?

        #mary = User.find_by_login("Mary Jackson")
        #assert mary.editor?
        #assert !mary.administrator?
      end

      should "find_with_role method" do
        User.find_with_role(:moderator, :uploader, :administrator).size.should == 2
      end
    end
  end
end
