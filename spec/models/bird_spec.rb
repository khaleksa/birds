require 'spec_helper'

describe Bird do
  subject { FactoryGirl.create :bird }

  it { should belong_to(:user)}

  describe '#set_big_year' do
    context 'with user who is participant of BigYear' do
      let(:user) { FactoryGirl.create :user, big_year: true }

      context 'with timestamp' do
        subject { FactoryGirl.create :bird, user: user, timestamp: Time.zone.now }
        it 'should set current year to big_year' do
          expect(subject.big_year).to eq(Time.zone.now.year)
        end
      end

      context 'without timestamp' do
        subject { FactoryGirl.create :bird, user: user }
        it 'should not set big_year' do
          expect(subject.big_year).to eq(0)
        end
      end
    end

    context 'with user who is not participant of BigYear' do
      let(:user) { FactoryGirl.create :user, big_year: false }
      subject { FactoryGirl.create :bird, user: user }
      it 'should not set big_year' do
        expect(subject.big_year).to eq(0)
      end
    end
  end

  describe '#update_big_year' do
    let(:user) { FactoryGirl.create :user, big_year: true }

    context "when bird is participant of BigYear" do
      subject { FactoryGirl.create :bird, user: user, timestamp: Time.zone.now }

      it 'should set 0 to big_year after update timestamp to the previous year' do
        expect{ subject.update_attributes(timestamp: 1.year.ago) }.to change{ subject.big_year }.from(Time.zone.now.year).to(0)
      end

      it 'should not change big_year after update timestamp to the same year' do
        expect{ subject.update_attributes(timestamp: 1.second.ago) }.not_to change{ subject.big_year }
      end
    end

    context "when bird wasn't participant of BigYear" do
      subject { FactoryGirl.create :bird, user: user, timestamp: 1.year.ago }

      it 'should set the current year to big_year after update timestamp to the current year' do
        expect{ subject.update_attributes(timestamp: Time.zone.now) }.to change{ subject.big_year }.from(0).to(Time.zone.now.year)
      end

      it 'should not change big_year after update timestamp to the previous year' do
        expect{ subject.update_attributes(timestamp: 2.years.ago) }.not_to change{ subject.big_year }
      end
    end
  end
end
