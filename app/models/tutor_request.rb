class TutorRequest < ActiveRecord::Base
	after_create :send_to_tutors

	def send_to_tutors
		destinations = User.available_devices("android")
		data = {subject: self.subject, name: self.name}
	    	# must be a hash with all values you want inside you notification
    		GCM.send_notification( destinations, data ) unless destinations.empty?
		#should do something android and ios also
		
		ios_destinations = User.available_devices("ios")
			ios_destinations.each do |t|
			notification = Houston::Notification.new
			notification.token = t
			notification.badge = 1
			notification.sound = "default"
			notification.content_available = true#uhhh
			notification.custom_data = {
				nameandsubject:self.name+"::"+self.subject}
			APN.push(notification)			
		end
	end

	def resolve(tutor)
		tutor.update_attribute(:tutoring,true)
		tutor.update_attributes(tutee_name:self.name,
					tutee_subject:self.subject)
		begin
			response=GCM.send_notification(User.available_devices("android"),{subject:self.subject,name:self.name,delete:"heck yeah"})
		rescue
			#puts "1<=devices<=100"
		end
		ios_destinations = User.available_devices("ios")
		ios_destinations.each do |t|
			notification = Houston::Notification.new
			notification.token = t
			notification.content_available = true
                        notification.sound = ""
                        notification.custom_data = {nameandsubject:self.name+"::"+self.subject+'delete'}
			#delete as separate key crashes ios app... huh.
                        APN.push(notification)


		end
		[response, self.destroy]
	end
end
