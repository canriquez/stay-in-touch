require 'rails_helper'

RSpec.describe 'User creates a new registered user', type: :feature do
  scenario 'they access the home page and click the signup button' do
    visit new_user_registration_path

    fill_in 'user[name]', with: 'exampleUser'
    fill_in 'user[email]', with: 'example@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('exampleUser')
  end
end
