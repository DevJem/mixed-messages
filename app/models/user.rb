class User < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_many :uploads, dependent: :destroy 
	has_many :blogs
	has_many :notifications
	has_and_belongs_to_many :reports
	has_secure_password

	before_save {self.email = email.downcase}
	validates :username, presence: true, length: {minimum: 3, maximum: 40},
		uniqueness: {case_sensitive: false}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	
	validates :email, presence: true, length: {maximum: 105},
		uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}, on: :create

	validates :password, presence: true, length: {minimum: 6, maximum: 32}, on: :create
	validates :password_confirmation, presence: true, length: {minimum: 6, maximum: 32}, on: :create
	validates_confirmation_of :password

	validates :bio, length: { maximum: 3000}
  validates :terms_and_conditions, acceptance: {accept: true}

	def self.search(search)
	  if search
	    where(['username LIKE ?', "%#{search}%"])
	  else
	    all
	  end
	end

end
