FactoryGirl.define do
  sequence(:uid)      { |n| "100#{n}" }
  sequence(:email)    { |n| "person#{n}@example.com" }
  # sequence(:token)    { |n| "$2a$04$iYyVoLaz.NaKk78uxOqJuOFEpi8f/JqwwzNym.nTo5KL9S1VpAev#{n}" }
  factory :user do
    email
    name "Jon Smith"
    role 'member'
    password "jonsmith"
    password_confirmation "jonsmith"
    provider "facebook"
    uid
    after :create do |b|
      b.update_column(:profile_photo, "#{Rails.root}/spec/support/images/image.png")
    end
  end
end
