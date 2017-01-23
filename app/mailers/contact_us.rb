class ContactUs < ApplicationMailer

	default from: "dithanial@gmail.com"

	def contact(user)
		@user = user
		mail (to: "jdehay@yahoo.com", title: :title, subject: :content)
	end
end
