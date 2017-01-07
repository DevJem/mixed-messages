class PagesController < ApplicationController
  API_KEY = "AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc"

  def home
  end

  def about
  end

  def how_to
  end

  def watch
    #if @videos = JSON.load(open("https://www.googleapis.com/youtube/v3/playlistItems?&part=contentDetails&playlistId=PLDEgt5YKZjd52qpLq54cry_9_47Rfs3An&maxResults=50&key=#{API_KEY}"))

    @PageToken = slide_params
    @PageToken.each do |k, v|
      puts "    k = #{k}, v = #{v}"
      if k == "format"
        puts v
        @PageToken = v
      else
        @PageToken = nil
      end
    end

    if @PageToken.nil?
      if @videos = JSON.load(open("https://www.googleapis.com/youtube/v3/playlistItems?&part=contentDetails&playlistId=PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU&maxResults=12&key=#{API_KEY}"))
      else redirect_to root_path
      end
    elsif !@PageToken.nil?
      if @videos = JSON.load(open("https://www.googleapis.com/youtube/v3/playlistItems?&part=contentDetails&playlistId=PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU&maxResults=12&key=#{API_KEY}#{@PageToken}"))
      else redirect_to root_path
      end
    end
  end

  def contact
  end

private
  def slide_params
    puts params
    
    params.each do |k, v|
      puts "k = #{k} "

    end
  end
end

# youtube data api key AIzaSyCx6Ry7sp2t4Trd1hlT22ZUxPfXkWJuMTc
# https://www.youtube.com/watch?v=_3cg_Efs0d8&list=PL6gx4Cwl9DGChV7XQAqGqy0tFkD3BuwIU