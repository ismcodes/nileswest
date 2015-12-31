class UsersController < ApplicationController
	def dashboard
		return render 'sign_in' unless session[:user_id]
		@users = User.where(loggedin: true)
		@message = ""
	end
	
	def get_status
		if params[:secret_key] == ENV["REQUEST_KEY"]
			user = User.where(email:params[:email]).first
			j  = {"tutoring"=> user.tutoring ? "YES I AM TUTOR" : "not tutoring"}.to_json
			render json: j
		else
			render nothing: true
		end
	end

	def change_status
		statuses = { 0 => "Not in Lit Center",
								 1 => "Tutoring",
								 2 => "Available" }

		if params[:secret_key] == ENV["REQUEST_KEY"]
			#oh...
			user = User.where(email: params[:email]).first

			case params[:status].to_i
			when 0
				user.update_attributes(loggedin:false,tutoring:false)
				user.update_attributes(tutee_name:nil,tutee_subject:nil)

			when 1
				user.update_attribute(:tutoring,true)
			when 2
				user.update_attributes(tutoring:false)
				user.update_attributes(tutee_name:nil,tutee_subject:nil)

			end

		end
		render nothing:true
	end

	def admin_login
puts params[:password]
puts ENV

		session[:user_id]=1 if params[:password] == ENV["STAFF_PASSWORD"]
		return redirect_to '/dashboard'

	end

	def admin_logout
		session[:user_id]=nil
		render nothing:true
	end

	def new_period
		if params[:secret_key] == ENV["REQUEST_KEY"]
			User.where(loggedin: true).each do |u|
				u.update_attribute(:loggedin, false)
			end
		end
		render nothing: true
	end

	def login

		if params[:secret_key] == ENV["REQUEST_KEY"]
			user = User.where(email: params[:email]).first
			user.update_attributes(name: params[:name]||user.name,
					image: params[:image]||user.image,loggedin:true)

			if rand > 0.99 || !user.image #if user has default google+ pic
				user.update_attribute(:image,"https://robohash.org/#{user.name}?set=set3&size=100x100")
			end

		end
		render nothing:true
	end

	def index

	end
end
