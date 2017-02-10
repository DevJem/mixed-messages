class CommentsController < ApplicationController


	def destroy
		@comment = Comment.find(params[:id])
		@flags = Report.where(comment_id: @comment.id)
		@flags.each {|f| f.destroy}
		@comment.destroy
		redirect_to :back
	end

	private

		def comment_params
			params.permit(:id)
		end
end