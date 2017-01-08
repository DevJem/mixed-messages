class VideosController < ApplicationController

	def show
		@video = video_params
	end

	private
		def video_params
			params.permit(:id) 
		end

end
