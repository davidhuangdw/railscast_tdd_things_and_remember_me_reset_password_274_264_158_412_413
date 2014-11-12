require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "password_reset" do
    let(:user) {create(:user, password_reset_token:'anything')}
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Reset password on rails")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["davidhuangdw@163.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(edit_password_reset_url(user.password_reset_token))
    end
  end
end
