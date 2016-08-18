FactoryGirl.define do
  factory :team do
    name "MyString"
    association :manager, factory: :player
    association :division, factory: :division
  end
end
