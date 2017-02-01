class ContactUs < ApplicationMailer

	default from: "from_contact@mixed-messages.org"
	default to: "jdehay@mixed-messages.org"

	def contact(message)
		@message = message
		mail(subject: "New message from contact us page")
	end
end
# from_contact@mixed-messages.org
# XJ2VF-58