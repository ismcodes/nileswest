class User < ActiveRecord::Base
 has_one :device
 def self.from_omniauth(auth)
    where(email:auth.info.email).first_or_initialize.tap do |user|
      # none of this is necessary...
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email=auth.info.email
      user.image=auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
scope :available_devices, lambda {|platform|
 where(loggedin:true,tutoring:false).map{|u|
if u.device
if u.device.platform.downcase == platform.downcase
u.device.token
end
end
}.select{|x|x}
 }
end
