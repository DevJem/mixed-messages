class UploadsController < ApplicationController
	before_action :set_upload, only: [:show, :edit, :update, :save_upload, :destroy]
	before_action :require_admin, only: [:review, :save_upload]

 
	def index
		@uploads = Upload.all
	end

	def review
		@uploads = Upload.where(save_upload: false)
	end

	def show
	end

	def new 
		@upload = Upload.new
	end

	def create

		@upload = Upload.new(upload_params)
		@upload.user = current_user

		if @upload.save
			flash[:success] = "Your upload has been submitted. You will be notified if it is accepted."
			redirect_to upload_path(@upload)
		else
			render :new
		end
	end

	def edit
	end

	def update 
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.upload_id = @upload.id
		if @comment.save
			@upload.comments << @comment
			upload_title = Upload.find(@comment.upload_id).title
			mark_video :comment, @comment.user_id, upload_title, "member", @upload.id
		else
			flash[:danger] = "Did not work. #{@comment.errors.full_messages}"
			render :show
		end
	end

	def save_upload
		@upload.toggle!(:save_upload)
		if @upload.save_upload
			mark_video :success, @upload.user_id, @upload.title, "admin"
		else
			mark_video :denied, @upload.user_id, @upload.title, "admin"
		end
	end


	def destroy
		mark_video :denied, @upload.user_id, @upload.title, "admin"
		@upload.remove_file!
		@upload.save
		@upload.destroy
		flash[:info] = "The upload #{@upload.title} has been deleted."
	end

	private
		def upload_params
			params.require(:upload).permit(:title, :note, :zipcode, :file)
		end

		def comment_params
			params.require(:comment).permit(:title, :comment, :upload_id, :user_id)
		end

		def set_upload
			@upload = Upload.find(params[:id])
		end

		def require_admin
			if !logged_in? || !current_user.admin 
				flash[:danger] = "Administrator access required for that action"
				redirect_to root_path
			end
		end

# submit_playlist_id = "PLDEgt5YKZjd7gLN4iUFnDm9xX6GGAWD0k"

end
