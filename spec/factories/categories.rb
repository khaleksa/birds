FactoryGirl.define do
  factory :category, class: 'Categories::Category ' do
    sequence(:name_ru) {|n| "Category_ru_#{n}" }
    sequence(:name_lat) {|n| "Category_lat_#{n}" }
    sequence(:name_en) {|n| "Category_en_#{n}" }
    sequence(:name_uz) {|n| "Category_uz_#{n}" }
  end

  factory :family, parent: :category, class: 'Categories::Family' do

  end

  factory :order, parent: :category, class: 'Categories::Order' do

  end
end
