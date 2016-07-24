FactoryGirl.define do
  factory :lift do
    sequence(:name) { |n| "Waterville Valley day trip#{n}" }
    deprture 'Boston'
    destination 'Waterville'
    description 'Day trip to Waterville'
    zip '02120'
    open_seats '2'
    departure_date '11/21/1988'
  end
end
