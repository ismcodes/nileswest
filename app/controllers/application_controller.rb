class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  def update
    render nothing:true unless params[:secret_key]==ENV["REQUEST_KEY"]
    respond_to do |format|
      format.json { render json: [User.where(loggedin:true,tutoring:false),User.where(loggedin:true,tutoring:true),TutorRequest.all]  }
    end

  end
end
