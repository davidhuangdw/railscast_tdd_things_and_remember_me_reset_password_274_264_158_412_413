class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true

  after_create { generate_token(:auth_token)}


  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.now
    save!
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
