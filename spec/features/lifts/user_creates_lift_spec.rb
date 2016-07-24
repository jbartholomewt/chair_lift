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
    fill_in 'Name', with: 'Waterville Valley day trip'
    fill_in 'Departure', with: 'Boston'
    fill_in 'Destination', with: 'Waterville'
    fill_in 'Description', with: 'Day trip to Waterville'
    fill_in 'Zip', with: '02120'
    fill_in 'Departure date', with: '1988/10/10'
    fill_in 'Open seats', with: "2"
    click_button 'Create Lift'

    expect(page).to have_content('Waterville Valley day trip')
    expect(page).to have_content('Lift successfully added!')

  end

  scenario 'user fills out Lift creation form unsuccessfully' do
    click_button 'Add Lift'
    fill_in 'Name', with: ''
    fill_in 'Departure', with: ''
    fill_in 'Destination', with: ''
    fill_in 'Description', with: ''
    fill_in 'Zip', with: ''
    fill_in 'Departure date', with: ''
    fill_in 'Open seats', with: ""
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
