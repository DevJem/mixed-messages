# Preview all emails at http://localhost:3000/rails/mailers/email_list
class EmailListPreview < ActionMailer::Preview
	def list
		message = Hash.new
		message[:title] = "Title"
		message[:content] = "Content"
		EmailList.list(message)
	end
end
