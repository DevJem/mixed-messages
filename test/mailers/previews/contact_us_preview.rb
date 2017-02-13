# Preview all emails at http://localhost:3000/rails/mailers/contact_us
class ContactUsPreview < ActionMailer::Preview
def contact
  	@contact = Contact.new
  	@contact.title = "test"
  	@contact.content = "This is a test email for previewing emails as a test"
  	@contact.user = "DevJem"
  	@contact.email = "boo@email.com"
  	ContactUs.contact(@contact)
  end
end
