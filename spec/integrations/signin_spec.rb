require 'rails_helper'

RSpec.describe 'User creates a new registered user', type: :feature do
  before(:each) do
    @user = User.new(name: 'exampleUser', email: 'example@example.com', password: 'password', password_confirmation: 'password')
    @user.save
  end
  scenario 'they access the home page and click the signup button' do
    visit new_user_session_path

    fill_in 'user[email]', with: 'example@example.com'
    fill_in 'user[password]', with: 'password'

    click_button 'Sign In'

    expect(page).to have_content('exampleUser')
  end
end
