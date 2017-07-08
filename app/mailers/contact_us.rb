class ContactUs < ApplicationMailer

	default from: "producers@mixed-messages.org"
	default to: "producers@mixed-messages.org"

	def contact(message)

		# options = {user_name: "from_contact@mixed-messages.org",
		# 					password: ENV['FROM_CONTACT_PW'] }

		@message = message
		# mail(subject: @message.title, delivery_method_options: options)
		mail(subject: @message.title)
	end
end
