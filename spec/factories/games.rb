FactoryGirl.define do
  factory :game do
    association :division, factory: :division
    association :home_team, factory: :team
    association :away_team, factory: :team
    kickoff "2016-08-14 07:51:48"
    referees_report "MyText"
    context 1
    referee_id 1
    field_id 1
    status 1
  end
end
