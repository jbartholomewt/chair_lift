require 'rails_helper'
require 'shoulda-matchers'
require 'valid_attribute'

describe Lift do
  it { should have_valid(:name).when('Lift Name1', 'Waterville Valley day trip') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:departure).when('Cambridge', 'Brighton') }
  it { should_not have_valid(:departure).when(nil, '') }

  it { should have_valid(:destination).when('Loon', 'Waterville') }
  it { should_not have_valid(:destination).when(nil, '') }

  it { should have_valid(:description).when('weeeeeee!', 'bring sandwiches') }
  it { should_not have_valid(:description).when(nil, '') }

  it { should have_valid(:zip).when('01770', '02030') }
  it { should_not have_valid(:zip).when(nil, '') }

  it { should have_valid(:departure_date).when('1988/10/10', '1988/11/10') }
  it { should_not have_valid(:departure_date).when(nil, '') }

  it { should have_valid(:open_seats).when('2', '4') }
  it { should_not have_valid(:open_seats).when(nil, '') }
end
