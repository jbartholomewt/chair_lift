require 'rails_helper'
# As an authenticated user
# I want to add a lift
# So that others can view it

feature 'user signs in and user creates Lift', :devise do
  before(:each) do
  valid_facebook_login_setup
  visit '/users/auth/facebook/callback'
  Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
  Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
end

  scenario 'user fills out lift creation form successfully' do
    click_button 'Add Lift'
    fill_in 'lift[name]', :with => 'Waterville Valley day trip'
    fill_in 'lift[open_seats]', :with => '2'
    fill_in 'lift[departure]', :with => 'Boston'
    fill_in 'lift[destination]', :with => 'Waterville'
    fill_in 'lift[description]', :with => 'day trip'
    fill_in 'lift[zip]', :with => '02120'
    fill_in 'datefield', :with => '1988/10/10'
    click_button 'Create Lift'

    expect(page).to have_content('Lift successfully added!')
    click_link 'List'
    expect(page).to have_content('Waterville Valley day trip')

  end

  scenario 'user fills out Lift creation form unsuccessfully' do
    click_button 'Add Lift'
    fill_in 'lift[name]', :with => ''
    fill_in 'lift[open_seats]', :with => ''
    fill_in 'lift[departure]', :with => ''
    fill_in 'lift[destination]', :with => ''
    fill_in 'lift[description]', :with => ''
    fill_in 'lift[zip]', :with => ''
    fill_in 'datefield', :with => ''
    click_button 'Create Lift'


    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Departure can't be blank")
    expect(page).to have_content("Destination can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Departure date can't be blank")
    expect(page).to have_content("Open seats can't be blank")
    expect(page).to have_content("Zip can't be blank, Zip is not a number")
    expect(page).to have_content("Zip is the wrong length")
  end
end
