class UploadsController < ApplicationController
	before_action :set_upload, only: [:show, :edit, :update, :save_upload, :destroy]
	before_action :require_admin, only: [:review, :save_upload]
	#before_action :require_user, only: [:new]
 
	def index
		#@uploads = Upload.where(save_upload: true).order("id DESC")
		@uploads = Upload.search(params[:search], params[:zip]).paginate(page: params[:page], per_page: 12).where(save_upload: true).order("id DESC")
		
		@tags = Tag.all
	end

	def review
		@uploads = Upload.paginate(page: params[:page], per_page: 12).where(save_upload: false).order("id ASC")
	end

	def show
		flags(params[:id], "upload-comment")
		@tags = Tag.all
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
		@comments = Comment.where(upload_id: @upload.id)
		@comments.each do |comment|
			@flags = Report.where(comment_id: comment.id)
			@flags.each {|f| f.destroy}
			comment.destroy
		end
		@upload.destroy
		flash[:info] = "The upload #{@upload.title} has been deleted."
	end

	def upload_report
		#@comment = Comment.find
	end

	def add_tags
		@temp = add_tags_params[:tags]
		@temp.pop
		@upload = Upload.find(add_tags_params[:upload_id])
		puts "Tags: #{@tags}"
		@upload.update tags: Tag.find(@temp)
		redirect_to :back
	end



	private
		def upload_params
			params.require(:upload).permit(:title, :note, :zipcode, :file)
		end

		def add_tags_params
			params.require(:add_tags).permit(:upload_id, tags: [])
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

		def require_user
			if !logged_in?
				redirect_to root_path
				flash[:warning] = "You must be logged in to do that."
			end
		end

# submit_playlist_id = "PLDEgt5YKZjd7gLN4iUFnDm9xX6GGAWD0k"

end
