FactoryGirl.define do
  factory :team do
    name 'MyString'
    association :manager, factory: :user
    association :division, factory: :division
    association :formation, factory: :formation
    uniform_colors 'Red'
  end
end
