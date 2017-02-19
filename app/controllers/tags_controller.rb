class TagsController < ApplicationController

	def index
		@tags = Tags.all
	end

	def new
		@tag = Tag.new
		@tags = Tag.all
	end

	def create
		@tag = Tag.new(tag_params)
		if @tag.save
			flash[:success] = "New tag #{@tag.tag_name} created."
			redirect_to :back
		else
			flash[:danger] = "Tag not created."
			redirect_to :back
		end
	end

	def destroy
		@tag = Tag.find(params[:id])
		@tag.destroy
		redirect_to :back
		flash[:success] = "Tag deleted."
	end

	private 

		def tag_params
			params.require(:tag).permit(:tag_name)
		end
end
