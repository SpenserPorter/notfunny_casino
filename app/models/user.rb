class User < ActiveRecord::Base

	has_one :balance

	#downcase email before saving
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	#validate entries for existence, name for max length, and proper formatting on email address
	validates :name, presence: true, length: { maximum: 25 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }

	#magic?
	has_secure_password

	#min password length
	validates :password, length: {minimum: 4}

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
