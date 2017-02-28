class PagesController < ApplicationController
  before_action :require_user, only: [:change_password, :reset]
   

  def home
    @blog = Blog.last
  end

  def logo
  end

  def google
  end

  def unsubscribe
  end

  def remove_email
    @email = Subscribe.where(subscribes: remove_email_params).first
    if !@email.nil?
      @user = User.where(email: @email.email).first
      @email.destroy
      @user.toggle!(:allow_emails)
      flash[:success] = "Your email has been removed from our mailing list."
      redirect_to root_path
    else
      flash[:warning] = "The email address entered does not exist in our database. Make sure you entered the correct email information and try again or contact us."
      redirect_to unsubscribe_path
    end
  end

  def safe
  end

  def change_password
  end

  def password_reset
    @new_password = reset_params
    @user = current_user
    if !@user.authenticate(@new_password[:old_password])
      flash[:danger] = "Old Password incorrect!"
      redirect_to :back
    elsif @new_password[:new_password] != @new_password[:confirm_new_password]
      flash[:danger] = "New password and confirmation password do not match."
      redirect_to :back
    elsif @new_password[:new_password].length < 6 or @new_password[:new_password].length > 32
        flash[:danger] = "New password must be between 6-32 characters."
        redirect_to :back
    elsif @new_password[:new_password] == @new_password[:old_password]
      flash[:danger] = "New password cannot match the old password"
      redirect_to :back
    else
      @user.password = @new_password[:new_password]
      @user.password_confirmation = @new_password[:new_password]
      @user.save
      if @user.require_password_reset
        @user.toggle!(:require_password_reset)
      end
      flash[:success] = "Password changed"
      redirect_to user_path(@user)
    end
  end

  # Form to allow users to reset their passwords
  def new_pw_by_email
    @email = email_reset_params
    @user = User.find_by(email: @email[:email].downcase)
    if !@user.nil?

      # create mailer to reset password here
      @new_password = Array.new(10).map { (65 + rand(58)).chr}.join
      @user.password = @new_password
      @user.save!
      ResetPasswordMailer.reset_password(@user, @new_password).deliver_now
      if !@user.require_password_reset
        @user.toggle!(:require_password_reset)
      end
      flash[:success] = "Password reset link sent to your email address. Follow the instructions to reset your password."
      redirect_to login_path
    else
      flash[:danger] = "Entered email doesn't exist in our database."
      render :send_pw_reset
    end
  end

  def about
  end

  def faq
  end

  def watch
    playlist_id = "PLDEgt5YKZjd52qpLq54cry_9_47Rfs3An" # real playlist
    #playlist_id = "PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU" # For testing
    key = ENV['API_KEY']
    puts "key is: #{ENV['API_KEY']}"
    json_url = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=#{playlist_id}&part=snippet&maxResults=12&key=#{key}"
    

    @PageToken = params
    @PageToken.each do |k, v|
      if k == "format"
        @PageToken = v
      else
        @PageToken = nil
      end
    end

    begin
      if @PageToken.nil?
        
        if @videos = JSON.load(open(json_url))
        else redirect_to root_path
        end
      elsif !@PageToken.nil?
        if @videos = JSON.load(open("#{json_url}#{@PageToken}"))
        else redirect_to root_path
        end
      end
    rescue
      flash[:warning] = "An error has occured trying to get the videos."
      redirect_to root_path
    end

  end

  def contact_us
  end

private

  def slide_params
  end

  def remove_email_params
    params.require(:unsubscribe).permit(:email)
  end

  def reset_params
    params.require(:password_reset).permit(:old_password, :new_password, :confirm_new_password)
  end

  def require_user
    if !logged_in?
      redirect_to root_path
      flash[:warning] = "You must be logged in to do that."
    end
  end

  def email_reset_params
    params.require(:reset_email).permit(:email)
  end
end
