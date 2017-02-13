# Preview all emails at http://localhost:3000/rails/mailers/welcome
class WelcomePreview < ActionMailer::Preview

	def welcome
		Welcome.welcome(User.first)
	end
end
