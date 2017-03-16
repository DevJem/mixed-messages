class NotificationsController < ApplicationController
	before_action :set_notice, only: [:show, :destroy]


	def index
		@notifications = Notification.all
	end

	def new
		@notification = Notification.new
		@params = params
	end 

	def create
		@notification = Notification.new(notice_params)

		#debugger
		if @notification.save
			if @notification.source_location == "member"
				redirect_to upload_path(Upload.find(@notification.source_id))
			elsif @notification.source_location == "admin"
				redirect_to review_path
			elsif @notification.source_location == "delete"
				redirect_to user_path(@notification.user_id)
			end
		else
			flash[:danger] = "Something went wrong, please try again later."
			redirect_to root_path
		end
	end

	def destroy notice
		@notification.destroy
		redirect_to user_path(current_user.id)
	end

	def delete_all
		
		kill = params[:id].split("/")
		kill.each do |x|
			note = Notification.find(x)
			note.destroy
		end
		redirect_to :back
	end


	private

		def notice_params
			params.require(:notification).permit(:id, :notice, :active, :notice_type, :user_id, :source, :source_location, :source_id)
		end

		def set_notice
			@notification = Notification.find(params[:id])
		end

end