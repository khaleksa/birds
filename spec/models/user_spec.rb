require 'spec_helper'

describe User do
  it { should have_many(:birds) }

  it { should validate_presence_of(:email)}
  it { should validate_uniqueness_of(:email)}

  it { should validate_presence_of(:password)}
  it { should ensure_length_of(:password).is_at_least(3).is_at_most(128) }

  describe '.big_year_members' do

  end
end


