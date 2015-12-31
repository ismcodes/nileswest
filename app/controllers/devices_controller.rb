class DevicesController < ApplicationController
def register
user = User.where(email:params[:email]).first

if user
token_fixed = "<"
params[:token].scan(/.{8}/) do |s|
token_fixed<<s+" "
end
token_fixed[-1]=">"

user.device.destroy if user.device

if params[:platform].downcase == "ios"
user.device = Device.new(token:token_fixed, platform:params[:platform])
else
user.device = Device.new(token:params[:token], platform:params[:platform])
end

end

render nothing:true
end

end
