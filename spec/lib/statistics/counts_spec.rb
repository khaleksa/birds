require 'spec_helper'
require 'statistics/counts'

describe Statistics::Counts do
  let(:current_year) { Time.zone.now.year }

  let(:order) { FactoryGirl.create :order }
  let(:family) { FactoryGirl.create :family, parent: order }
  let(:species1) { FactoryGirl.create :species, category_id: family.id }
  let(:species2) { FactoryGirl.create :species, category_id: family.id }
  let(:species3) { FactoryGirl.create :species, category_id: family.id }

  let!(:expert) { FactoryGirl.create :user_expert }

  let!(:user1) { FactoryGirl.create :user }
  let!(:user1_bird1) { FactoryGirl.create :bird, user: user1, species: species1, expert_id: expert.id, published: true}
  let!(:user1_bird2) { FactoryGirl.create :bird, user: user1, species: species2, expert_id: expert.id, published: true, big_year: current_year }
  let!(:user1_bird3) { FactoryGirl.create :bird, user: user1, species: species2, expert_id: expert.id, published: false, big_year: current_year }
  let!(:user1_bird4) { FactoryGirl.create :bird, user: user1, species: species3, published: true }

  let!(:user2) { FactoryGirl.create :user }
  let!(:user2_bird1) { FactoryGirl.create :bird, user: user2, species: species1, expert_id: expert.id, published: true }
  let!(:user2_bird2) { FactoryGirl.create :bird, user: user2, species: species3 }

  let!(:user3) { FactoryGirl.create :user }
  let!(:user3_bird1) { FactoryGirl.create :bird, user: user3, species: species1, expert_id: expert.id, published: true }
  let!(:user3_bird2) { FactoryGirl.create :bird, user: user3, species: species2, expert_id: expert.id, published: true }

  describe '.total_users_species_amount' do
    subject { described_class.total_users_species_amount }

    it 'returns total species amount of published & approved birds' do
      expect(subject).to eq(2)
    end
  end

  describe '.users_birds' do
    subject { described_class.users_birds }

    it 'returns all users' do
      expect(subject.size).to eq(4)
    end

    it 'returns amount of published birds for every user' do
      user_max_amount = subject.first
      expect(user_max_amount.id).to eq(user1.id)
      expect(user_max_amount.birds_count).to eq(3)
      user_min_amount = subject.last
      expect(user_min_amount.id).to eq(expert.id)
      expect(user_min_amount.birds_count).to eq(0)
      user2_rec = subject.detect { |record| record if record.id == user2.id }
      expect(user2_rec.birds_count).to eq(1)
    end
  end

  describe '.user_species' do
    it 'returns total amount of species met by user' do
      expect(described_class.user_species(user1)).to include(species1, species2)
      expect(described_class.user_species(user2)).to include(species1)
    end
  end

end
