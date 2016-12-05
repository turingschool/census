# require 'rails_helper'
#
# RSpec.feature 'User logs in' do
#   scenario 'by providing email and password' do
#     user = create_user
#     visit root_path
#     fill_in 'Email', with: user.email
#     fill_in 'Password', with: user.password
#     click_button 'Log in'
#
#     expect(page).to have_content('Turing Directory')
#     expect(page).to have_content("#{user.first_name} #{user.last_name}")
#   end
#
#   def create_user
#     User.create(first_name: 'Jeff',
#                 last_name: 'Casimir',
#                 email: ENV['MY_EMAIL'],
#                 password: 'password',
#                 password_confirmation: 'password',
#                 confirmed_at: Time.now)
#   end
# end
