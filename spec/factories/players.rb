FactoryGirl.define do
  factory :player do
    association :user, factory: :user
    status 'Ready to Register and Pay!'
    first "MyString"
    last "MyString"
    email "MyString"
    phone "MyString"
    positions "MyString"
    keeper false
    attendance_estimate 1
    ideal_minutes 1
    why "MyText"
    paid "MyString"
    ebssl_card false
  end
end
