FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    dob { Faker::Date.between(70.years.ago, 28.years.ago.at_end_of_year) }
    trait :admin do
      role 'admin'
    end

  end
end
