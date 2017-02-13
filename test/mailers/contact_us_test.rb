require 'test_helper'

class ContactUsTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end

  def contact
  	@contact = Contact.new
  	@contact.title = "test"
  	@contact.content = "This is a test email for previewing emails as a test"
  	@contact.save
  	ContactUs.contact(@contact)
  end
end
