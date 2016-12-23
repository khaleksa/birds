FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test_#{n}@test.ru" }
    sequence(:first_name) {|n| "TestName_#{n}" }
    sequence(:last_name) {|n| "TestFamily_#{n}" }
    password '123456'
    password_confirmation '123456'
  end
end
