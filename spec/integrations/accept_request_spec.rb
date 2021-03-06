require 'rails_helper'

RSpec.describe 'User creates a new registered user', type: :feature do
  before(:each) do
    @user = User.new(name: 'exampleUser1',
                     email: 'example1@example.com',
                     password: 'password',
                     password_confirmation: 'password')
    @user.save
    @user = User.new(name: 'exampleUser2',
                     email: 'example2@example.com',
                     password: 'password',
                     password_confirmation: 'password')
    @user.save
  end

  scenario 'they access the home page and click the signin button' do
    visit new_user_session_path

    fill_in 'user[email]', with: 'example1@example.com'
    fill_in 'user[password]', with: 'password'

    click_button 'Sign In'

    click_link 'All users'

    click_button 'Send request'

    # Second user login
    click_link 'Sign out'

    visit new_user_session_path

    fill_in 'user[email]', with: 'example2@example.com'
    fill_in 'user[password]', with: 'password'

    click_button 'Sign In'

    click_link 'All users'

    click_button 'Accept Request'

    expect(page).to have_content('Friend')
  end
end
