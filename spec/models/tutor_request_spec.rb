require 'rails_helper'

RSpec.describe TutorRequest, "#resolve", :type => :model do
before(:each) do
	#before each b/c request gets destroyed when resolved
	@tr = TutorRequest.create(name:"isaac", subject:"physics")
	@u = User.create(email:"testuser@example.com", loggedin:true, tutoring:false)
  end
  
  it "should destroy itself when resolved" do
  	expect{@tr.resolve(@u)}.to change(TutorRequest, :count).by -1
  end
    
  skip it "should send delete notification when resolved" do
	#doesn't send success response because no real tokens

	#expect the GCM status to be returned
	response = @tr.resolve(@u)[0]
	#android = response[0]
	#ios = response[1]
	expect(response).to be_an Array
	expect(response).to include(:response => "success")
	expect(response).to include(:status_code => 200)
  end

end
