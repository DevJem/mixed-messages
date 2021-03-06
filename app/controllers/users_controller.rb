class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update, :show, :ban, :make_admin]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	before_action :require_admin, only: [:destroy, :ban, :make_admin, :index, :elist]

	def index
		@users = User.search(params[:search]).paginate(page: params[:page], per_page: 21)
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
				if @user.allow_emails
					Subscribe.create(email: @user.email)
				end
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
		if @user.update(user_params)
			checkSub = Subscribe.where(email: @user.email)
			if @user.allow_emails && checkSub == nil
				Subscribe.create(email: @user.email)
			end
			flash[:success] = "Your account was successfully updated."
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def show
		@user_uploads = @user.uploads.order("id DESC").paginate(page: params[:page], per_page: 6)
		@user_notes = @user.notifications.paginate(page: params[:page], per_page: 8)
	end

	def destroy 
		@user = User.find(params[:id])

		if @user.admin
			flash[:danger] = "You cannot delete another admin"
		else
			session[@user.id] = nil
			# Destroy notifications
			note = Notification.where(user_id: @user.id)
			if note != nil
				note.each {|x| x.destroy}
			end
			# Remove from mail list
			user_sub = Subscribe.where(email: @user.email)

			if !user_sub.empty?
				Subscribe.destroy(user_sub.first.id)
			end

			uname = @user.username
			@user.delete
			flash[:danger] = "User #{uname} has been deleted."
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
		@users = Subscribe.all.paginate(page: params[:page], per_page: 21).order('id ASC')
		write_list @users
	end

	def send_mass_email
		@message = Hash.new
		Subscribe.all.each do |subscriber|
			@message = {email: subscriber.email,
									subject: send_email_params[:subject],
									content: send_email_params[:content]
								}
			EmailList.list(@message).deliver_later 
		end
		flash[:success] = "Email sent!"
		redirect_to :back
	end

	def email_download
		clear_list
		redirect_to root_path
	end


	private
	def user_params
		params.require(:user).permit(:username, :email, :password, :zipcode, :bio, :password_confirmation, :allow_emails, :terms_and_conditions)
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

	def send_email_params
		params.require(:send_email).permit(:subject, :content) 
	end

	def write_list users
		if logged_in? and current_user.admin? and Rails.env.production?
			File.open("tmp/emails.csv", "w") do |f|
				users.each do |user|
					f.puts user.email
				end
			end
		end
	end

	def clear_list
		if logged_in? and current_user.admin? and Rails.env.production?
			File.open("tmp/emails.csv", "w") do |f|
				f.puts " "
			end
		end
	end


end