class EmailList < ApplicationMailer
	default from: "producers@mixed-messages.org"

	def list(message)
		@message = message
		mail(to: @message[:email], subject: @message[:subject])
	end
end
