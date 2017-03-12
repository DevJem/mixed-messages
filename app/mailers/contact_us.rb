class ContactUs < ApplicationMailer

	default from: "from_contact@mixed-messages.org"
	default to: "producers@mixed-messages.org"

	def contact(message)

		options = {user_name: "from_contact@mixed-messages.org",
							# password: ENV['FROM_CONTACT_PW']
							password: "XJ2VF-58"}


		@message = message
		mail(subject: @message.title, delivery_method_options: options)
	end
end
 