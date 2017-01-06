class BlogsController < ApplicationController

	before_action :set_blog, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
		@blogs = Blog.paginate(page: params[:page], per_page: 3).order('id DESC')
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = Blog.new(blog_params)
		@blog.user = current_user

		if @blog.save
			flash[:success] = "Blog has been created."
			redirect_to blogs_path
		else
			redirect_to blogs_path
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
			redirect_to blogs_path
		else
			render :edit
		end
	end

	def destroy
		@blog.destroy
		flash[:danger] = "The blog \"#{@blog.title}\" was deleted."
		redirect_to blogs_path
	end

	private

		def blog_params
			params.require(:blog).permit(:title, :content)
		end

		def set_blog
			@blog = Blog.find(params[:id])
		end

		def require_same_user
		if current_user != @article.user and !current_user.admin?
			flash[:danger] = "You can only edit or delete your own article"
			redirect_to root_path
		end		
	end

end
