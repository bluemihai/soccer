FactoryGirl.define do
  factory :card do
    game_id 1
    player_id 1
    red false
    yellow false
    minute 1
    details "MyText"
  end
end
