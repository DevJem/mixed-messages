class PagesController < ApplicationController
   

  def home
    @blog = Blog.last
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

    if @PageToken.nil?
      
      if @videos = JSON.load(open(json_url))
      else redirect_to root_path
      end
    elsif !@PageToken.nil?
      if @videos = JSON.load(open("#{json_url}#{@PageToken}"))
      else redirect_to root_path
      end
    end
  end

  def contact 

  end

private
  #API_KEY="AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc"

  def slide_params
  end

end

# youtube data api key AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc
# https://www.youtube.com/watch?v=_3cg_Efs0d8&list=PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU