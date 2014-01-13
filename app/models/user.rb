class User < ActiveRecord::Base
	#downcase email before saving
	before_save { self.email = email.downcase }

	#validate entries for existence, name for max length, and proper formatting on email address
	validates :name, presence: true, length: {maximun: 25}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
	uniqueness: true { case_sensitive: false }

	#magic?
	has_secure_password

	#min password length
	validates :password, length: { minimum: 4 }
end
