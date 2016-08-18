FactoryGirl.define do
  factory :goal do
    association :game, factory: :game
    association :team, factory: :team
    association :scorer, factory: :player
    association :assister, factory: :player
    struck_with 1
    minute 1
    details "MyText"
  end
end
