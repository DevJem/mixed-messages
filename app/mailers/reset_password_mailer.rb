class ResetPasswordMailer < ApplicationMailer
	# default from: "Webmaster@mixed-messages.org"
	default from: "producers@mixed-messages.org"

	def reset_password(user, new_password)
		# options = {user_name: "webmaster@mixed-messages.org",
		# 					 password: ENV['WEBMASTER_PW']}

		@new_password = new_password
		@user = user

		# mail(to: @user.email, subject: "Mixed Messages | Your password has been reset", delivery_method_options: options)
		mail(to: @user.email, subject: "Mixed Messages | Your password has been reset")

	end
end
