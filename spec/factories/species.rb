FactoryGirl.define do
  factory :species do
    sequence(:name_lat) {|n| "Species_#{n}" }
  end

end
