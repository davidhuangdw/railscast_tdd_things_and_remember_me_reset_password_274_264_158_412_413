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
  it 'does not email invalid user when requesting password reset' do
    visit login_path
    click_link "Forgotten"
    fill_in "Email", with: 'nobody@email.com'
    click_button "Reset Password"
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Email sent')
    expect(last_email).not_to be_present
  end

  let(:user) { create(:user, password_reset_token:'anthing', password_reset_sent_at: 1.hours.ago) }
  let(:edit_path) { edit_password_reset_path(user.password_reset_token) }
  let(:update_path) {password_reset_path(user.password_reset_token)}
  it "update the user password when confirm matches" do
    visit edit_path
    fill_in 'Password', with:'123'
    click_button 'Update Password'
    expect(current_path).to eq update_path
    expect(page).to have_content("doesn't match")
    fill_in 'Password', with:'123'
    fill_in 'Password confirmation', with:'123'
    click_button 'Update Password'
    expect(current_path).to eq root_path
  end
end
