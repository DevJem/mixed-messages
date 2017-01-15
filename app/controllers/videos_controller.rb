class VideosController < ApplicationController
 
	def show
		@video = video_params
	end

	def new
		@label
		@location = ""
	end

	def create
		location = ""
		params.each do |k, v|
			if k == "video"
				v.each {|x| location = x}
			end
		end

		set_location(location)
		redirect_to watch_path
	end

	def premium
		
	end

	def add_comment
		@comment = Comment.new(comment_params)
		@video = video_params
		@video.each do |k, v|
			@comment.video_id = v
			@comment.user_id = current_user.id
			if @comment.save
				redirect_to video_path(v)
			else
				flash[:danger] = "#{@comment.errors.full_messages}"
				render :show
			end
		end
	end

	private
		def video_params
			params.permit(:id) 
		end

		def comment_params
			params.require(:comment).permit(:title, :comment, :user_id)
		end

end
