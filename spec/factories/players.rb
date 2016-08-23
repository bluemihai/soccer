FactoryGirl.define do
  factory :player do
    # association :user, factory: :user
    status 'Ready to Register and Pay!'
    approved true
    first "MyString"
    last "MyString"
    email "MyString"
    phone "MyString"
    position Player.positions.keys.first
    keeper false
    attendance_estimate 1
    ideal_minutes 1
    why "MyText"
    paid "MyString"
    ebssl_card false
  end
end
