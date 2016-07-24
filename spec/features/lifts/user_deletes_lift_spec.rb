require 'rails_helper'

feature 'user deletes lift' do
  before(:each) do
  valid_facebook_login_setup
  visit '/users/auth/facebook/callback'
  Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
  Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
end


  scenario 'user visits lift show page and deletes lift' do
    click_button 'Add Lift'
    fill_in 'Name', with: 'Waterville Valley day trip'
    fill_in 'Departure', with: 'Boston'
    fill_in 'Destination', with: 'Waterville'
    fill_in 'Description', with: 'Day trip to Waterville'
    fill_in 'Zip', with: '02120'
    fill_in 'Departure date', with: '1988/10/10'
    fill_in 'Open seats', with: "2"
    click_button 'Create Lift'
    click_on "Waterville Valley day trip"
    click_button 'Delete'

    expect(Lift.all).to eq([])
    expect(page).to_not have_content("Waterville Valley day trip")
    expect(page).to have_content('Recent Lifts')
  end
  # scenario 'user does not see delete link on lift detail page they did not create' do
  #   user2 = FactoryGirl.create(:user)
  #   login_user(user2)
  #   click_link lift.name
  #
  #   expect(page).to_not have_content('Delete')
  # end
end
