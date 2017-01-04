class BlogsController < ApplicationController

	before_action :set_blog, only: [:edit, :update, :show, :destroy]

	def index
		@blogs = Blog.paginate(page: params[:page], per_page: 3)
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = Blog.new(blog_params)
		@blog.user = User.first

		if @blog.save
			flash[:success] = "Blog has been created."
			redirect_to blog_path(@blog)
		else
			render :new
		end
	end

	def show
	end

	def edit
		if Blog.find(params[:id])
		else
			render '/public/404.html'
		end
	end

	def update
		if @blog.update(blog_params)
			flash[:success] = "The blog #{@blog.title} was successfully updated."
			redirect_to blog_path(@blog)
		else
			render :edit
		end
	end

	def destroy
		@blog.destroy
		flash[:danger] = "The blog #{@blog.title} was deleted."
		redirect_to blogs_path
	end

	private

		def blog_params
			params.require(:blog).permit(:title, :content)
		end

		def set_blog
			@blog = Blog.find(params[:id])
		end

end
