class ReportsController < ApplicationController

	before_action :require_admin, only: [:index, :unflag]

	def index

		@reports = Report.all

		# @reports.each do |report|
		# 	report.count = 0
		# end
		add = Report.first
		@reports.each do |report|
			add = Report.where(comment_id: report.comment_id)
		end
		if !add.nil?
			add.each {|a| a.count += 1; a.save}
		end

		 @reports.sort_by {|report| report.count}
	end

	def new
		@flag = Report.new
	end

	def create
		@flag = Report.new(report_params)
		if @flag.save
			flash[:success] = "Report successful"
			redirect_to :back
		else
			flash[:danger] = "Report did not work. Please email us for support."
			redirect_to :back
		end
	end

	def destroy
		@comment = Comment.find(unflag_params[:comment_id])
		@comment.destroy
		redirect_to :back
	end

	def unflag 
		@flags = Report.where(comment_id: unflag_params[:comment_id])
		@flags.each {|f| f.destroy}
		redirect_to reports_path
	end

	private

		def report_params
			params.require(:report).permit(:user_id, :comment_id, :blog_id, :upload_id, :video_id)
		end

		def unflag_params
			params.require(:report).permit(:comment_id)
		end

		def require_admin
			if !logged_in? or !current_user.admin?
				flash[:danger] = "You must be an administrator to do that."
				redirect_to root_path
			end
		end
end
