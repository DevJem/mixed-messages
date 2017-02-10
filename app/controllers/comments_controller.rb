class CommentsController < ApplicationController


	def destroy
		@comment = Comment.find(params[:id])
		mark_video :report, @comment.user_id, nil, "delete"
		@flags = Report.where(comment_id: @comment.id)
		@flags.each {|f| f.destroy}
		@user = User.find(@comment.user_id)
		@user.warn_level += 1
		@user.save
		@comment.destroy

#		redirect_to :back
	end

	private

		def comment_params
			params.permit(:id)
		end
end