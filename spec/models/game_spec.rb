require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { FactoryGirl.create(:game) }

  it '#home_goals works' do
    puts game.inspect
    puts game.away_team.inspect, game.away_team.persisted?
    FactoryGirl.create(:goal, game: game, team: Team.find(1))
    # FactoryGirl.create(:goal, game: game, team: game.away_team)
    # FactoryGirl.create(:goal, game: game, team: game.away_team)
    # FactoryGirl.create(:goal, game: game, team: game.home_team)
  end
end
