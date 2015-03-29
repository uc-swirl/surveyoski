require 'spec_helper'

describe User do
  it "Should be able to find a user by name" do
  	  #attr_accessor :name, :phone_number, :email, :password, :active
  	  ben = User.create(:name => "Ben", :email => "marcojoemontagna@gmail.com")
  	  #expect { User.where(:username => "Ben").first }.to be_truthy
          User.where(:name => "Ben").first.should_not be_nil
  end

  it "Shouldn't find nonexistant users" do
    #expect { User.where(:username => "Ben").first }.to be_nil
    User.where(:name => "Ben").first.should be_nil
  end

  it "Users should respond to #name" do
	ben = User.create(:name => "Ben Poodles", :email => "marcojoemontagna@gmail.com")
 	expect(ben).to respond_to(:name)
  end

  it "User's should respond to #email" do
	ben = User.create(:name=> "Ben Poodles", :email => "marcojoemontagna@gmai.com")
 	expect(ben).to respond_to(:email)
  end


end
