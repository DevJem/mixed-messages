class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :get_location, :set_location, :mark_video, :flags

  def current_user
  	@current_user ||= User.find session[:user_id] if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:danger] = "You must be logged in to perform that action"
  		redirect_to root_path 
  	end
  end
 
  # Get and set the url for the premium video 
  def get_location
    last_known = String
    File.open("public/location", "r") { |io| last_known = io.gets  }
    @@location ||= "https://www.youtube.com/embed/#{last_known}?rel=0"
  end

  def set_location(new_location)
    @@location = "https://www.youtube.com/embed/#{new_location}?rel=0"
    File.open("public/location", "w") { |io| io.puts new_location }
  end


  # Set up notifications mark video success, denied, or comment
  def mark_video(result, user, source, location = nil, id = nil) # 

    if result == :success
      notice = "Your video \"#{source}\" has been approved."
      type = "success"
    elsif result == :denied
      notice = "Your upload \"#{source}\" has been denied"
      type = "danger"
    elsif result == :comment
      notice = "You have a new comment on your upload \"#{source}\""
      type = "info"
    elsif result == :report
      notice = "A comment you made has been deleted for violating our TOS. Repeated offenses will result in a ban."
      type = "danger"
    end

      notification = {user_id: user, notice: notice, notice_type: type, source: source, source_location: location, source_id: id}
      redirect_to new_notification_path(notification)
  end


  # Set up global flags for uploads and comments

  def flags(id, type)
    if type == "blog-comment"
      @flags = Report.where(blog_id: id)
    elsif type == "upload-comment"
      @flags = Report.where(upload_id: id)
    elsif type == "video-comment"
      @flags = Report.where(video_id: id)
    end
  end

end
