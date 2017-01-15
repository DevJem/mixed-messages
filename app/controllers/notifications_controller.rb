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
				redirect_to uploads_path
			end
		else
			flash[:danger] = "Something went wrong, please try again later."
			redirect_to root_path
		end
	end

	def destroy
		@notification.destroy
		redirect_to user_path(current_user.id)
	end

	def delete_all
		
		kill = params[:id].split("/")
		puts "kill = #{kill}"
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