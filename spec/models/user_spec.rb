require 'spec_helper'

describe User do
  it "Should be able to find a user by name" do
  	  ben = User.create(:name => "Ben", :email => "marcojoemontagna@gmail.com")
      User.where(:name => "Ben").first.should_not be_nil
  end

  it "Shouldn't find nonexistant users" do
    User.where(:name => "Ben").first.should be_nil
  end

  it "responds to #name" do
	  ben = User.create(:name => "Ben Poodles", :email => "marcojoemontagna@gmail.com")
 	  expect(ben).to respond_to(:name)
  end

  it "responds to #status" do
    ben = User.create(:name => "Ben Poodles", :email => "marcojoemontagna@gmail.com", :status => "student")
    expect(ben).to respond_to(:status)
  end

  it "responds to #email" do
  	ben = User.create(:name=> "Ben Poodles", :email => "marcojoemontagna@gmai.com")
   	expect(ben).to respond_to(:email)
  end

end
