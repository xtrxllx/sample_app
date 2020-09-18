class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates: email, presence: true, length: {maximum: Settings.user.email.max_length}, format: {with: VALID_EMAIL_REGEX}
  
  validates: name, presence: true 
  has_secure_password

end
