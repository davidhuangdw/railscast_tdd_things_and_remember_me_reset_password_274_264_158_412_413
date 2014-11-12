
class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, on: :create

  include Authentication

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
