FactoryGirl.define do
  factory :player do
    # association :user, factory: :user
    status 'Ready to Register and Pay!'
    name { Faker::Name.name }
    first "MyString"
    last "MyString"
    email { Faker::Internet.free_email }
    phone { Faker::PhoneNumber.phone_number }
    position 1
    attendance_estimate 1
    ideal_minutes 1
    sequence(:jersey )
    why "MyText"
    paid "MyString"
    approved true
    ebssl_card false
    has_jersey false
    invited false
    keeper false
  end
end
