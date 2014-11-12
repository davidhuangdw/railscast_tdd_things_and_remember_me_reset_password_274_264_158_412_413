require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "password_reset" do
    let(:user) {create(:user)}
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Reset password on rails")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["davidhuangdw@163.com"])
    end

    it "renders the body" do
    end
  end
end
