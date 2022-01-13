class User < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email,password)
      
      user = self.find_by_email(email.strip.downcase)
      
      if user && user.authenticate(password)
          return user
      end
          return false
      end
  end

