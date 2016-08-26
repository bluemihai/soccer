require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:a) { FactoryGirl.create(:team) }
  let(:h) { FactoryGirl.create(:team) }
  let(:a1) { FactoryGirl.create(:player, team: a) }
  let(:a2) { FactoryGirl.create(:player, team: a) }
  let(:h1) { FactoryGirl.create(:player, team: h) }
  let(:game) { FactoryGirl.create(:game, away_team: a, home_team: h) }

  it '#home_goals works' do
    FactoryGirl.create(:goal, game: game, team: a, scorer: a1, assister: a2)
    FactoryGirl.create(:goal, game: game, team: a, scorer: a1, assister: a2)
    FactoryGirl.create(:goal, game: game, team: a, scorer: a2, assister: a1)
    FactoryGirl.create(:goal, game: game, team: h, scorer: h1)
    expect(game.home_goals.count).to eq 1
    expect(game.away_goals.count).to eq 3
  end
end
