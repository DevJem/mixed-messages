class PagesController < ApplicationController
  API_KEY = "AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc"

  def home
  end

  def about
  end

  def how_to
  end

  def watch
    if @videos = JSON.load(open("https://www.googleapis.com/youtube/v3/playlistItems?&part=contentDetails&playlistId=PLDEgt5YKZjd52qpLq54cry_9_47Rfs3An&maxResults=50&key=#{API_KEY}"))
    else
      redirect_to root_path
    end
    
  end

  def contact
  end

private

end

# youtube data api key AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc