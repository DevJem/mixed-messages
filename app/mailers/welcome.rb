class Welcome < ApplicationMailer

	default from: "producers@mixed-messages.org"

	def welcome(user)
		@user = user
		mail(to: @user.email, subject: "Welcome To Mixed Messages!")
	end

end
