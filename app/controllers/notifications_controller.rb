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
		debugger
		if @notification.save
			flash[:success] = "Notification successful"
			
		else
			flash[:danger] = "Notification failed"
			
		end
	end

	def destroy
		@notification.destroy
		redirect_to user_path(current_user.id)
	end


	private

		def notice_params
			params.permit(:id, :notice, :active, :notice_type, :user_id, :source)
		end

		def set_notice
			@notification = Notification.find(params[:id])
		end

end