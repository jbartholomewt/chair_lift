require 'rails_helper'

feature 'user edits bar' do
  before(:each) do
  valid_facebook_login_setup
  visit '/users/auth/facebook/callback'
  Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
  Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]

  click_button 'Add Lift'
  fill_in 'lift[name]', :with => 'Waterville Valley day trip'
  fill_in 'lift[open_seats]', :with => '2'
  fill_in 'lift[departure]', :with => 'Boston'
  fill_in 'lift[destination]', :with => 'Waterville'
  fill_in 'lift[description]', :with => 'day trip'
  fill_in 'lift[zip]', :with => '02120'
  fill_in 'datefield', :with => '1988/10/10'
  click_button 'Create Lift'
end

scenario "User searches a Lift's name and sees that lift listed" do
  fill_in "query", with: 'Waterville Valley day trip'
  click_on("Search")

  expect(page).to have_content('Waterville Valley day trip')
end

scenario "User searches a Lift's departure location and sees that lift listed" do
  fill_in "query", with: 'Boston'
  click_on("Search")

  expect(page).to have_content('Boston')
end

scenario "User searches a Lift's departure date and sees that lift listed" do
  fill_in "query", with: '1988'
  click_on("Search")

  expect(page).to have_content('10/10/1988')
end
end
