class User < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, length: {minimum: 4}
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  def authenticate_with_credentials(email, password)
    if self.authenticate(password)==self && email.strip.downcase == self.email.downcase
      
    return self
    else
      return nil
    end
  end
end
