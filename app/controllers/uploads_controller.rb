class UploadsController < ApplicationController

	def index
		@uploads = Upload.all
	end

	def show
		@upload = Upload.find(params[:id])
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

	def destroy
		@upload = Upload.find(params[:id])
		@upload.destroy
		flash[:info] = "The upload #{@upload.title} has been deleted."
		redirect_to uploads_path
	end

	private
		def upload_params
			params.require(:upload).permit(:title, :note, :zipcode, :file)
		end

# submit_playlist_id = "PLDEgt5YKZjd7gLN4iUFnDm9xX6GGAWD0k"

end
