class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true

  def send_password_reset
    UserMailer.password_reset(self).deliver
  end
end
