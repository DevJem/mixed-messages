class SessionsController < ApplicationController

	before_action :verify_login, only: [:new]

	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)

		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "You have logged in"
			redirect_to root_path
		else
			flash.now[:danger] = "There was something wrong with your login information"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have logged out."
		redirect_to :back
	end

	private

		def verify_login
			if logged_in?
				flash[:success] = "You are already logged in."
				redirect_to root_path
			end
			
		end

end
