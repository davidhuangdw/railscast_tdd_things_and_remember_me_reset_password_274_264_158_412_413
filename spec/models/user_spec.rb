require 'rails_helper'

describe User, :type => :model do
  let(:user) {create(:user)}
  describe '#send_password_reset' do
    before {user.send_password_reset}
    it "generate a unique password_reset_token each time" do
      last_token = user.password_reset_token
      user.send_password_reset
      expect(user.password_reset_token).not_to eq(last_token)
    end

    it "saves the time the password reset was sent" do
      expect(user.password_reset_sent_at).to be_present
    end

    it "deliver email to user" do
      expect(last_email.to).to include(user.email)
    end
  end
end
