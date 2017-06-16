require 'spec_helper'
require 'statistics/big_year'

describe Statistics::BigYear do
  let(:current_year) { Time.zone.now.year }

  let(:order) { FactoryGirl.create :order }
  let(:family) { FactoryGirl.create :family, parent: order }
  let(:species1) { FactoryGirl.create :species, category_id: family.id }
  let(:species2) { FactoryGirl.create :species, category_id: family.id }
  let(:species3) { FactoryGirl.create :species, category_id: family.id }

  let!(:user1) { FactoryGirl.create :user }
  let!(:user1_subscription1) { FactoryGirl.create :subscription, user: user1, year: current_year - 1 }
  let!(:user1_subscription2) { FactoryGirl.create :subscription, user: user1, year: current_year }
  let!(:expert) { FactoryGirl.create :user_expert }

  let!(:user1_bird1) { FactoryGirl.create :bird, user: user1, species: species1, expert_id: expert.id, published: true, big_year: current_year, timestamp: Time.zone.now }
  let!(:user1_bird2) { FactoryGirl.create :bird, user: user1, species: species1, expert_id: expert.id, published: true, big_year: current_year, timestamp: Time.zone.now }
  let!(:user1_bird3) { FactoryGirl.create :bird, user: user1, species: species2, expert_id: expert.id, published: true, big_year: current_year, timestamp: Time.zone.now }
  let!(:user1_bird4) { FactoryGirl.create :bird, user: user1, species: species3, expert_id: expert.id, published: true, big_year: 2.years.ago.year, timestamp: 2.years.ago }
  let!(:user1_bird5) { FactoryGirl.create :bird, user: user1, species: species3, expert_id: expert.id, published: false, big_year: current_year, timestamp: Time.zone.now }
  let!(:user1_bird6) { FactoryGirl.create :bird, user: user1, species: species3, published: true, big_year: current_year, timestamp: Time.zone.now }
  let!(:user1_bird7) { FactoryGirl.create :bird, user: user1, published: true, big_year: current_year, timestamp: Time.zone.now }

  let!(:user2) { FactoryGirl.create :user }
  let!(:user2_bird1) { FactoryGirl.create :bird, user: user2, species: species1, expert_id: expert.id, published: true, timestamp: Time.zone.now }

  let!(:user3) { FactoryGirl.create :user }
  let!(:user3_subscription) { FactoryGirl.create :subscription, user: user3, year: 2.years.ago.year }
  let!(:user3_bird1) { FactoryGirl.create :bird, user: user3, species: species1, expert_id: expert.id, published: true }

  let!(:user4) { FactoryGirl.create :user }
  let!(:user4_subscription) { FactoryGirl.create :subscription, user: user4, year: current_year }
  let!(:user4_bird1) { FactoryGirl.create :bird, user: user4, species: species1, expert_id: expert.id, published: true, big_year: current_year, timestamp: Time.zone.now }
  let!(:user4_bird2) { FactoryGirl.create :bird, user: user4, species: species1, expert_id: expert.id, published: true, big_year: current_year, timestamp: Time.zone.now }

  describe '.users_species_count' do

    subject { described_class.users_species_count }

    it 'returns number of species for every participant of BigYear' do
      expect(subject.size).to eq(2)
      user1_record = subject.first
      expect(user1_record.id).to eq(user1.id)
      expect(user1_record.species_count).to eq(2)
      user4_record = subject.last
      expect(user4_record.id).to eq(user4.id)
      expect(user4_record.species_count).to eq(1)
    end
  end

  describe '.species' do
    subject { described_class.species current_year }

    it 'returns all species met by participants of BigYear during year' do
      expect(subject.size).to eq(2)
      expect(subject).to include(species1, species2)
    end
  end

  describe '.users_count' do
    it 'returns amount of BigYear participants for all years' do
      expect(described_class.users_count).to eq(3)
    end
  end

  describe '.user_species_count' do
    it "returns amount of user's species during BigYear" do
      expect(described_class.user_species_count user1.id, current_year).to eq(2)
      expect(described_class.user_species_count user4.id, current_year).to eq(1)
    end
  end

  describe '.user_rating' do
    it "returns user's place in BigYear rating" do
      expect(described_class.user_rating user1.id, current_year).to eq(1)
      expect(described_class.user_rating user4.id, current_year).to eq(2)
    end
  end
end
