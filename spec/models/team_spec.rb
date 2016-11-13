require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should respond_to(:name) }
  let (:team) { FactoryGirl.create(:team) }
  
  it '#update_lineup works' do
    [11, 12, 21, 22, 31, 32].each do |idx|
      FactoryGirl.create(:player, id: idx, team: team)
    end
    args = {
      1 => 11,
      2 => 12,
      0 => [21, 22],
      nil => [31, 32]
    }
    team.update_roster(args)
    expect(team.lineup[1]).to eq({first_name: 'MyString', id: 11})
  end
end
