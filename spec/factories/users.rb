FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    liability_waiver_agreed true
    email { Faker::Internet.free_email }
    dob { Faker::Date.between(70.years.ago, 28.years.ago.at_end_of_year) }
    trait :admin do
      role 'admin'
    end
    league_history 'No'
  end
end
