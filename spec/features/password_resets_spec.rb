require 'rails_helper'

describe "PasswordResets", type: :request do
  it 'emails user when requesting password reset' do
    user = create(:user)
    visit login_path
    click_link "Forgotten"
    fill_in "Email", with: user.email
    click_button "Reset Password"
    expect(current_path).to eq(root_path)
    expect(last_email.to).to include(user.email)
    expect(page).to have_content('Email sent')
  end
end
