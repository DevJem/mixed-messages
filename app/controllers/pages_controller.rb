class PagesController < ApplicationController
  

  def home
  end

  def about
  end

  def how_to
  end

  def watch

    @PageToken = params
    @PageToken.each do |k, v|
      if k == "format"
        @PageToken = v
      else
        @PageToken = nil
      end
    end

    if @PageToken.nil?
      if @videos = JSON.load(open("https://www.googleapis.com/youtube/v3/playlistItems?&part=snippet&playlistId=PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU&maxResults=9&key=#{ENV['API_KEY']}"))
      else redirect_to root_path
      end
    elsif !@PageToken.nil?
      if @videos = JSON.load(open("https://www.googleapis.com/youtube/v3/playlistItems?&part=snippet&playlistId=PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU&maxResults=9&key=#{ENV['API_KEY']}#{@PageToken}"))
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

  # def get_key
  #   API_KEY
  # end
end

# youtube data api key AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc
# https://www.youtube.com/watch?v=_3cg_Efs0d8&list=PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU