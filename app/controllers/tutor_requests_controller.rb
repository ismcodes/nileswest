class TutorRequestsController < ApplicationController


  def request_tutor
    #is there a better name for this method?
    #TutorRequests#request seems redundant
    
    # sends a notification to all available tutors
    TutorRequest.create(subject:params[:subject],name:params[:name])
    # @message = "Created request for #{params[:name]} for tutoring in #{params[:subject]}"
    render nothing:true
  end

  def resolve
    if params[:secret_key] == ENV["REQUEST_KEY"]
      tr = TutorRequest.where(subject:params[:subject],name:params[:name]).first
      tr.resolve(User.where(email:params[:email]).first)
    end
    render nothing:true
  end

  def all_current
    if params[:secret_key] == ENV["REQUEST_KEY"]
      formatted = TutorRequest.all.map{|tr| "#{tr.name}|#{tr.subject}" }
      render json: formatted.join("|")
    else
      render nothing:true
    end
  end

end
