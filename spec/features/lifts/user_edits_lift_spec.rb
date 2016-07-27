require 'rails_helper'

feature 'user edits bar' do
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

  click_on "Waterville Valley day trip"

  click_button 'Edit'

  fill_in 'lift[name]', :with => 'Waterville Valley day trip 2'

    click_button 'Update Lift'

    expect(page).to have_content('Waterville Valley day trip 2')
  end

#   scenario 'user visits detail page and edits bar info unsuccessfully' do
#     login_user(user)
#     visit bars_path
#     click_link bar.name
#     click_link 'Edit'
#
#     fill_in 'Name', with: 'The Mission'
#     fill_in 'Address', with: ''
#     fill_in 'Zip', with: 'unknown'
#     click_button 'Update Bar'
#
#     expect(page).to have_content("Address can't be blank, Zip is not a number,")
#     expect(page).to have_content("Zip is the wrong length (should be 5 characters)")
#   end
#   scenario 'user does not see edit link on bar detail page they did not create' do
#     user2 = FactoryGirl.create(:user)
#     login_user(user2)
#     click_link bar.name
#
#     expect(page).to_not have_content('Edit')
#   end
# end
