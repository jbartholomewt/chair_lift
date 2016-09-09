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
    fill_in 'lift[name]', :with => 'Waterville Valley day trip'
    fill_in 'lift[open_seats]', :with => '2'
    fill_in 'lift[departure]', :with => 'Boston'
    fill_in 'lift[destination]', :with => 'Waterville'
    fill_in 'lift[description]', :with => 'day trip'
    fill_in 'lift[zip]', :with => '02120'
    fill_in 'datefield', :with => '1988/10/10'
    click_button 'Create Lift'
    click_link 'List'
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
