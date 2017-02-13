class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update, :show, :ban, :make_admin]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	before_action :require_admin, only: [:destroy, :ban, :make_admin, :index, :elist]

	# def index
	# 	@users = User.paginate(page: params[:page], per_page: 10)
	# 	@results = User.where(username: ["username LIKE ?", "%#{search}"])
	# end 

	def index
		@users = User.search(params[:search]).paginate(page: params[:page], per_page: 9)
	end

	def new
		if !logged_in?
			@user = User.new
		else
			flash[:success] = "You are already logged in."
			redirect_to root_path
		end
	end

	def create
		@user = User.new(user_params)

		# Add Recaptcha to signup
		# respond_to do |format|

			if verify_recaptcha(model: @user) && @user.save
				Welcome.welcome(@user).deliver_now
				flash[:success] = "Welcome to Mixed-Messages, #{@user.username}!"
				session[:user_id] = @user.id
				redirect_to user_path(@user)
			else
				render 'new'
			end
	end
 
	def edit
	end 

	def update
		if verify_recaptcha(model: @user) && @user.update(user_params)
			flash[:success] = "Your account was successfully updated."
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def show
		@user_uploads = @user.uploads.order("id DESC").paginate(page: params[:page], per_page: 6)
	end

	def destroy
		@user = User.find(params[:id])
		if @user.admin
			flash[:danger] = "You cannot delete another admin"
		else
			@user.delete
			flash[:danger] = "User has been deleted."
			redirect_to users_path
		end
	end

	def ban
		@user.toggle!(:banned)
		redirect_to users_path
	end

	def make_admin
		@user.toggle!(:admin)
		redirect_to users_path
	end

	def elist
		@users = User.where(allow_emails: true).paginate(page: params[:page], per_page: 12)
	end


	private
	def user_params
		params.require(:user).permit(:username, :email, :password, :zipcode, :bio, :password_confirmation, :allow_emails)
	end

	def set_user
		@user = User.find(params[:id])		
	end

	def require_same_user
		if logged_in? && current_user != @user && !current_user.admin?
			flash[:danger] = "You can only edit your own account"
			redirect_to root_path
		end		
	end

	def require_admin
		if !logged_in? or !current_user.admin?
			flash[:danger] = "Only admin users can perform that action"
			redirect_to root_path
		end
	end


end