require 'rails_helper'

RSpec.describe User, ".available_devices", :type => :model do
	before(:all) do
	@user = User.create(email:"bob@example.com",
				loggedin:true, tutoring:false)

	@user.device = Device.new(token:"test", platform:"Android")
	end

	it "should get device token of new tutor added" do		
		devices = User.available_devices("Android")
		expect(devices).to be_an Array #only getting the tokens back
		expect(devices).to include "test"
		
	end 

	it "should not retrieve other platform devices" do		
		devices = User.available_devices("iOS")
		expect(devices).to_not include "test"
	end

	it "should get devices for any platform" do
		@user.device.update_attribute(:platform, "iOS")
		expect(User.available_devices("iOS")).to include("test")
		@user.device.update_attribute(:platform, "fake os")
		expect(User.available_devices("fake os")).to include("test")
	end
	
	it "should raise error if no platform is passed in" do
		expect{User.available_devices()}.to raise_error(ArgumentError)
	end

end
