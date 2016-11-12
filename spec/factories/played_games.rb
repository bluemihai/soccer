FactoryGirl.define do
  factory :played_game do
    game_id 1
    player_id 1
    team_id 1
    formation_id 1
    starting_position 1
    rsvp "MyString"
    red_card_minute 1
    yellow_card_minute 1
    card_details "MyString"
    team_comments "MyText"
  end
end
