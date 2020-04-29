require 'rails_helper'

RSpec.describe 'User creates a new registered user', type: :feature do
  before(:each) do
    @user = User.new(name: 'exampleUser1',
                     email: 'example1@example.com',
                     password: 'password',
                     password_confirmation: 'password')
    @user.save
  end

  scenario 'they access the home page and comment a post' do
    visit new_user_session_path

    fill_in 'user[email]', with: 'example1@example.com'
    fill_in 'user[password]', with: 'password'

    click_button 'Sign In'

    fill_in 'post[content]', with: 'post Test'

    click_button 'Save'

    fill_in 'comment[content]', with: 'Comment Test'

    click_button 'Comment'

    expect(page).to have_content('Comment Test')
  end
end
