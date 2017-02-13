class PagesController < ApplicationController
   

  def home
    @blog = Blog.last
  end

  def logo
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

  def about
  end

  def faq
  end

  def watch
    #playlist_id = "PLDEgt5YKZjd52qpLq54cry_9_47Rfs3An"
    key = ENV['API_KEY']
    playlist_id = "PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU"
    json_url = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=#{playlist_id}&part=snippet&maxResults=9&key=#{key}"
    # json_url = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=PLDEgt5YKZjd52qpLq54cry_9_47Rfs3An&part=snippet&maxResults=9&key=AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc"

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
  #API_KEY="AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc"

  def slide_params
  end

  def remove_email_params
    params.require(:unsubscribe).permit(:email)
  end

end

# youtube data api key AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc
# https://www.youtube.com/watch?v=_3cg_Efs0d8&list=PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU