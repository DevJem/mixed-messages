class ContactsController < ApplicationController

	def new
		@contact = Contact.new
	end

	def create
		if logged_in?
			@contact = Contact.new(contacts_params)
			@contact.user = current_user.username
			@contact.email = current_user.email
			if @contact.valid?
				ContactUs.contact(@contact).deliver_now
				flash[:success] = "Email sent, we'll respond as soon as we can."
				redirect_to root_path
			else
				flash[:danger] = "Failed to send email."
				render :new
			end
		end
	end

	private
		def contacts_params
			params.require(:contact).permit(:title, :content)
		end

end
