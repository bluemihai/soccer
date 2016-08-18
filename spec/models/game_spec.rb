require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { FactoryGirl.create(:game) }

  it '#home_goals works' do
    FactoryGirl.create(:goal, game: game, team: game.away_team)
    FactoryGirl.create(:goal, game: game, team: game.away_team)
    FactoryGirl.create(:goal, game: game, team: game.away_team)
    FactoryGirl.create(:goal, game: game, team: game.home_team)
    expect(game.home_goals.count).to eq 1
    expect(game.away_goals.count).to eq 3
  end
end
